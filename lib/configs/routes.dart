import 'package:flutter/material.dart';
import 'package:tabibu/views/appointment/appointment_screen.dart';
import 'package:tabibu/views/auths/forgot_password_otp.dart';
import 'package:tabibu/views/auths/forgot_password_screen.dart';
import 'package:tabibu/views/auths/login.dart';
import 'package:tabibu/views/auths/password_reset_screen.dart';
import 'package:tabibu/views/auths/profile_screen.dart';
import 'package:tabibu/views/auths/signup.dart';
import 'package:tabibu/views/clinics/clinics_screen.dart';
import 'package:tabibu/views/clinics/map_screen.dart';
import 'package:tabibu/views/home/home_base_screen.dart';

class RouteGenerator {
  static const String homeBasePage = '/home';
  static const String clinicPage = "clinics/";
  static const String profilePage = "profile/";
  static const String appointmentPage = "/appointment";
  static const String mapPage = "/map";
  static const String loginPage = "/";
  static const String signUpPage = "/signup";
  static const String forgotPasswordPage = "/forgotPassword";
  static const String forgotPasswordOtpPage = "/forgotPasswordOTP";
  static const String passwordResetPage = "/passwordReset";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeBasePage:
        return MaterialPageRoute(
          builder: (_) => HomeBaseScreen(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case signUpPage:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (_) => PasswordResetPhoneScreen(),
        );
      case forgotPasswordOtpPage:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordOTPScreen(),
        );
      case passwordResetPage:
        return MaterialPageRoute(
          builder: (_) => PasswordResetScreen(),
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
