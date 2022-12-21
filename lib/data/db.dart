import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tabibu/data/models/login_model.dart';
import 'package:tabibu/data/models/otp_check_model.dart';
import 'package:tabibu/data/models/sign_up_model.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  Box<LoggedInUser>? loginUserDetailsBox;
  Box<SignUp>? signUpAllDetailsBox;
  Box<SignUpUser>? signUpUserDetails;
  Box<TokenCheck>? tokenCheckAllPhoneNumberDetails;
  Box<Data>? tokenCheckPhoneNumber;

  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox("loginDetailsBox");
    loginUserDetailsBox = await Hive.openBox("loginUserBox");
    signUpAllDetailsBox = await Hive.openBox("signUpDetailsBox");
    signUpUserDetails = await Hive.openBox("signUpUserBox");
    tokenCheckAllPhoneNumberDetails =
        await Hive.openBox("tokenCheckAllPhoneNumberDetails");
    tokenCheckPhoneNumber = await Hive.openBox("tokenCheckPhoneNumber");
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoggedInUserAdapter());
    Hive.registerAdapter(LoginAdapter());
  }

  _signUpAdapters() async {
    Hive.registerAdapter(SignUpAdapter());
    Hive.registerAdapter(SignUpUserAdapter());
  }

  _passwordResetTokenCheckPhoneNumberAdapters() async {
    // Hive.registerAdapter();
  }

  init() async {
    await Hive.initFlutter();
    await _signUpAdapters();
    await _loginAdapters();
    await _initBoxes();
  }
}

DataBase db = DataBase();
// flutter pub run build_runner build --delete-conflicting-outputs
