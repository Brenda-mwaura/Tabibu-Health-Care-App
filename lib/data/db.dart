import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tabibu/data/models/login_model.dart';
import 'package:tabibu/data/models/sign_up_model.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  Box<LoggedInUser>? loginUserDetailsBox;
  Box<SignUp>? signUpAllDetailsBox;
  Box<SignUpUser>? signUpUserDetails;

  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox("loginDetailsBox");
    loginUserDetailsBox = await Hive.openBox("loginUserBox");
    signUpAllDetailsBox = await Hive.openBox("signUpDetailsBox");
    signUpUserDetails = await Hive.openBox("signUpUserBox");
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoggedInUserAdapter());
    Hive.registerAdapter(LoginAdapter());
  }

  _signUpAdapters() async {
    Hive.registerAdapter(SignUpAdapter());
    Hive.registerAdapter(SignUpUserAdapter());
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
