import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/configs/styles.dart';

class GoogleSignInProvider extends ChangeNotifier {
  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;

  set loadingLogin(bool value) {
    _loadingLogin = value;
    notifyListeners();
  }

  final _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _loginToast() {
    Fluttertoast.showToast(
      msg: "Login Successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _loginToastError() {
    Fluttertoast.showToast(
      msg: "Incorrect phone or password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future googleLogin() async {
    _loadingLogin = true;
    final googleUser = await _googleSignIn.signIn();
    print("Google User:: $googleUser");
    if (googleUser != null) {
      _user = googleUser;
      _loadingLogin = false;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      _loadingLogin = false;

      notifyListeners();
    }
    if (googleUser == null) {
      _loadingLogin = false;
      return;
    }
  }

  Future signInWithGoogle(String? token) async {
    _loadingLogin = true;
    return Api.googleSignin(token).then((response) async {
      var payload = jsonDecode(response.body);
      if (response.statusCode == 201) {
        _loadingLogin = false;
      } else {
        notifyListeners();
        _loadingLogin = false;
      }
    }).catchError((error) {
      print("error occured during user login $error");
    });
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}

GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();
