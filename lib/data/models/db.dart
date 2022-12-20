import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DataBase {
  _initBoxes() async {}

  init() async {
    await Hive.initFlutter();
    await _initBoxes();
  }
}

DataBase db = DataBase();
