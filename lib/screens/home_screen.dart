import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:naya_project/enums/user_state.dart';
import 'package:naya_project/provider/user_provider.dart';
import 'package:naya_project/resources/auth_methods.dart';
import 'package:naya_project/resources/local_db/repo/log_repo.dart';
import 'package:naya_project/screens/pagevies/logs/log_screen.dart';
import 'package:naya_project/utils/universal_utilities.dart';
import 'package:provider/provider.dart';

import 'call_screens/pickup/pickup_layout.dart';
import 'pagevies/chat_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController pageController;
  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();
  UserProvider userProvider;

  final AuthMethods _authMethods = AuthMethods();
  // final LogRepository _logRepository = LogRepository(isHive: true);
  // final LogRepository _logRepository = LogRepository(isHive: false);

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );

      LogRepository.init(
        isHive: true,
        dbName: userProvider.getUser.uid,
      );
    });

    WidgetsBinding.instance.addObserver(this);

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    double _labelFontSize = 10;

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: PageView(
          children: <Widget>[
            ChatListScreen(),
            LogScreen(),
            Center(
                child: Text(
              "Contact Screen",
              style: TextStyle(color: Colors.white),
            )),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.chat, size: 30),
            Icon(Icons.call, size: 30),
            Icon(Icons.contact_phone, size: 30),
          ],
          color: UniversalVariables.blackColor,
          buttonBackgroundColor: UniversalVariables.blackColor,
          backgroundColor: UniversalVariables.blueColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: navigationTapped,
        ),
      ),
    );
  }
}
