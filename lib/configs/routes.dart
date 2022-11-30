import 'package:flutter/material.dart';
import 'package:tabibu/views/clinics_screen.dart';
import 'package:tabibu/views/home_screen.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String clinicPage = "clinics/";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case clinicPage:
        return MaterialPageRoute(
          builder: (_) => ClinicScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
