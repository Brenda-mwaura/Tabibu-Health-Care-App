import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tabibu/api/api.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/login_model.dart';
import 'package:tabibu/data/db.dart';
import 'package:tabibu/data/models/password_reset_phone_number_model.dart';
import 'package:tabibu/data/models/password_reset_token_check_model.dart';
import 'package:tabibu/data/models/sign_up_model.dart';

class AuthProvider extends ChangeNotifier {
  Login get allLoginDetails => db.loginAllDetailsBox!.getAt(0)!;

  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;

  set loadingLogin(bool value) {
    _loadingLogin = value;
    notifyListeners();
  }

  void _loginToast() {
    Fluttertoast.showToast(
      msg: "Login Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _loginToastError() {
    Fluttertoast.showToast(
      msg: "Incorrect phone or password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future login(String phone, String password) async {
    _loadingLogin = true;
    return Api.login(phone, password).then((response) async {
      print("Status::: ${response.statusCode}");
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        Login loginDetails = Login.fromJson(payload);

        await db.loginAllDetailsBox!.clear();
        await db.loginAllDetailsBox!.add(loginDetails);

        notifyListeners();
        _loginToast();
        _loadingLogin = false;
        return loginDetails;
      } else {
        _loginToastError();
        _loadingLogin = false;
      }
    }).catchError((error) {
      _loginToastError();
      _loadingLogin = false;
      print("error occured during user login $error");
    });
  }

  SignUp get allSignUpdetails => db.signUpAllDetailsBox!.getAt(0)!;

  bool _loadingSignUp = false;
  bool get loadingSignUp => _loadingSignUp;

  set loadingSignUp(bool value) {
    _loadingSignUp = value;
    notifyListeners();
  }

  void _signUpToast() {
    Fluttertoast.showToast(
      msg: "Sign up successful, Enter the OTP sent to your phone.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _signUpErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future signUp(
    String? phone,
    String? email,
    String? fullName,
    String? password,
    String? passwordConfirmation,
  ) {
    _loadingSignUp = true;
    return Api.patientSignUp(
            phone, email, fullName, password, passwordConfirmation)
        .then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 201) {
        SignUp signUpDetails = SignUp.fromJson(payload);

        await db.signUpAllDetailsBox!.clear();
        await db.loginAllDetailsBox!.clear();
        await db.signUpAllDetailsBox!.add(signUpDetails);
        notifyListeners();
        _signUpToast();

        _loadingSignUp = false;
        return signUpDetails;
      } else {
        print(payload);
        _signUpErrorToast(payload);
        _loadingSignUp = false;
      }
    }).catchError((error) {
      _signUpErrorToast("Account sign up failed!");
      _loadingSignUp = false;
      print("error occured during account creation $error");
    });
  }

  bool _otpLoading = false;
  bool get otpLoading => _otpLoading;

  set otpLoading(bool value) {
    _otpLoading = value;
    notifyListeners();
  }

  void _otpSuccessToast() {
    Fluttertoast.showToast(
      msg: "Account successfully verified",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _otpErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future otp(String? token) {
    _otpLoading = true;
    return Api.activationOtp(token).then((response) {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        notifyListeners();
        _otpSuccessToast();
        _otpLoading = false;
        return payload;
      } else {
        _otpSuccessToast();
        _otpLoading = false;
      }
    }).catchError((error) {
      _otpErrorToast("Account verification failed!");
      _otpLoading = false;
      print("error occured during account verification $error");
    });
  }

  bool _passwordResetPhoneLoading = false;
  bool get passwordResetPhoneLoading => _passwordResetPhoneLoading;

  set passwordResetPhoneLoading(bool value) {
    _passwordResetPhoneLoading = value;
    notifyListeners();
  }

  void _passwordResetPhoneNumberSuccessToast() {
    Fluttertoast.showToast(
      msg: "Enter the OTP sent to your phone",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _passwordResetPhoneNumberErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  PasswordResetPhoneNumber get passwordResetPhoneDetailsDb =>
      db.passwordResetPhoneNumberAllDetails!.getAt(0)!;
  Future passwordResetPhoneNumber(String? phoneNumber) {
    _passwordResetPhoneLoading = true;
    return Api.passwordResetPhoneNumber(phoneNumber).then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        PasswordResetPhoneNumber passwordResetDetails =
            PasswordResetPhoneNumber.fromJson(payload);

        await db.loginAllDetailsBox!.clear();
        await db.signUpAllDetailsBox!.clear();
        await db.passwordResetPhoneNumberAllDetails!.clear();
        await db.passwordResetPhoneNumberAllDetails!.add(passwordResetDetails);

        print(
            "Phone Number:::${db.passwordResetPhoneNumberAllDetails!.getAt(0)!.data!.phone}");
        notifyListeners();
        _passwordResetPhoneNumberSuccessToast();
        _passwordResetPhoneLoading = false;
        return payload;
      } else {
        _passwordResetPhoneNumberErrorToast(payload["error"]);
        _passwordResetPhoneLoading = false;
      }
    }).catchError((error) {
      _passwordResetPhoneNumberErrorToast(error);
      _passwordResetPhoneLoading = false;
      print("error occured while requesting otp $error");
    });
  }

  bool _isPasswordOTPLoading = false;
  bool get isPasswordOTPLoading => _isPasswordOTPLoading;

  set isPasswordOTPLoading(bool value) {
    _isPasswordOTPLoading = value;
    notifyListeners();
  }

  void passwordResetTokenCheckSuccessToast() {
    Fluttertoast.showToast(
      msg: "OTP successfully verified",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void passwordResetTokenCheckErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future passwordResetTokenCheck(String? token) async {
    _isPasswordOTPLoading = true;
    return await Api.passwordResetTokenCheck(token).then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        TokenCheck passwordResetTokenCheck = TokenCheck.fromJson(payload);

        await db.loginAllDetailsBox!.clear();
        await db.signUpAllDetailsBox!.clear();
        await db.passwordResetTokenAllDetails!.clear();
        await db.passwordResetTokenAllDetails!.add(passwordResetTokenCheck);

        notifyListeners();
        _passwordResetPhoneNumberSuccessToast();
        _isPasswordOTPLoading = false;
      } else {
        _passwordResetPhoneNumberErrorToast(payload["error"]);
        _isPasswordOTPLoading = false;
      }
    }).catchError((error) {
      passwordResetTokenCheckErrorToast(error);
      _isPasswordOTPLoading = false;
      print("error occured while checking the password reset token $error");
    });
  }
}

AuthProvider authProvider = AuthProvider();
