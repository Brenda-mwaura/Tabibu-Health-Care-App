import 'dart:async';

import "package:flutter/material.dart";
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/db.dart';

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
      Navigator.of(context).pushNamed(RouteGenerator.welcomePage);
    });
  }
}
