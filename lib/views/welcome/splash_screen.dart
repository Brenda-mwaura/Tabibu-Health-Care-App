import 'dart:async';

import "package:flutter/material.dart";
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initDatabase() async {
    await db.init();
  }

  @override
  void initState() {
    goNext();
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Center(
        child: Image.asset("assets/images/tabibu_logo.png"),
      ),
    );
  }

  void goNext() {
    Timer(Duration(seconds: 3), () async {
      //show onboarding if first time using shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? seen = prefs.getBool('seen');
      if (seen == null || seen == false) {
        Navigator.of(context).pushNamed(RouteGenerator.welcomePage);
      } else {
        if (db.loginAllDetailsBox!.length > 0) {
          Navigator.of(context).pushNamed(RouteGenerator.homeBasePage);
        } else {
          Navigator.of(context).pushNamed(RouteGenerator.loginPage);
        }
      }
    });
  }
}
