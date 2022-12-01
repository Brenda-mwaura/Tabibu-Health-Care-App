import 'package:flutter/material.dart';
import 'package:tabibu/views/appointment/appointment_screen.dart';
import 'package:tabibu/views/auths/profile_screen.dart';
import 'package:tabibu/views/clinics/clinics_screen.dart';
import 'package:tabibu/views/clinics/map_screen.dart';
import 'package:tabibu/views/home/home_base_screen.dart';
import 'package:tabibu/views/home/home_screen.dart';

class RouteGenerator {
  static const String homeBasePage = '/';
  static const String homePage = "home/";
  static const String clinicPage = "clinics/";
  static const String profilePage = "profile/";
  static const String appointmentPage = "/appointment";
  static const String mapPage = "/map";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeBasePage:
        return MaterialPageRoute(
          builder: (_) => HomeBaseScreen(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case clinicPage:
        return MaterialPageRoute(
          builder: (_) => ClinicScreen(),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case appointmentPage:
        return MaterialPageRoute(
          builder: (_) => AppointmentScreen(),
        );
      case mapPage:
        return MaterialPageRoute(
          builder: (_) => MapScreen(),
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
