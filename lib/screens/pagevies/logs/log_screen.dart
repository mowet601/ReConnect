import 'package:flutter/material.dart';
import 'package:naya_project/Widgets/main_appbar.dart';
import 'package:naya_project/screens/call_screens/pickup/pickup_layout.dart';
import 'package:naya_project/screens/pagevies/logs/widgets/floating_column.dart';
import 'package:naya_project/screens/pagevies/logs/widgets/log_list_container.dart';
import 'package:naya_project/utils/universal_utilities.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: MainAppBar(
          title: "Calls",
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, "/search_screen"),
            ),
          ],
        ),
        floatingActionButton: FloatingColumn(),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogListContainer(),
        ),
      ),
    );
  }
}
