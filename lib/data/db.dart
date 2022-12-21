import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:tabibu/data/models/login_model.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  Box<LoggedInUser>? loginUserDetailsBox;
  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox("loginDetailsBox");
    loginUserDetailsBox = await Hive.openBox("loginUserBox");
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoggedInUserAdapter());
    Hive.registerAdapter(LoginAdapter());
  }

  init() async {
    await Hive.initFlutter();
    await _loginAdapters();
    await _initBoxes();
  }
}

DataBase db = DataBase();
// flutter pub run build_runner build --delete-conflicting-outputs
