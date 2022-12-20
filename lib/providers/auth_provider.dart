import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/configs/styles.dart';

class AuthService extends ChangeNotifier {
  void _loginToast() {
    Fluttertoast.showToast(
      msg: "Login Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _loginToastError() {
    Fluttertoast.showToast(
      msg: "Incorrect email or password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;

  set loadingLogin(bool value) {
    _loadingLogin = value;
    notifyListeners();
  }

  Future login(String phone, String password) async {
    _loadingLogin = true;
    return Api.login(phone, password).then((response) {
      var payload = json.decode(response.body);
      notifyListeners();
      _loginToast();
      _loadingLogin = false;
      return payload;
    }).catchError((error) {
      _loginToastError();
      _loadingLogin = false;
      print("error occured during user login $error");
    });
  }
}
