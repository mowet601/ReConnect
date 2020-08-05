import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naya_project/resources/auth_methods.dart';

import 'package:naya_project/utils/universal_utilities.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthMethods _authMethods = AuthMethods();
  AnimationController controller;
  Animation animation;

  bool isLoginPressed = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('assets/logo.png'),
                  height: 60.0,
                ),
                TypewriterAnimatedTextKit(
                  text: ['ReConnect'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text(
                'A Blazing fast video and chat app',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            Center(
              child: _signInButton(),
            ),
            isLoginPressed
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () => performLogin(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: UniversalVariables.senderColor,
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void performLogin() {
    print("tring to perform login");

    setState(() {
      isLoginPressed = true;
    });

    _authMethods.signIn().then((FirebaseUser user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _authMethods.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });

      if (isNewUser) {
        _authMethods.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
