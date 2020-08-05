import 'package:flutter/material.dart';
import 'package:naya_project/models/user.dart';
import 'package:naya_project/resources/auth_methods.dart';


class UserProvider with ChangeNotifier {
  User _user;
  AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
