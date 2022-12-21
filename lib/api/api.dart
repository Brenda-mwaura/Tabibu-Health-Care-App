import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tabibu/app_config.dart';
import 'package:tabibu/providers/auth_provider.dart';

class Api {
  static var baseUrl = AppConfig.appUrl;
  static var client = http.Client();

  static Future<http.Response> login(String phone, String password) async {
    var response = await client.post(
      Uri.parse("${baseUrl}login/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "phone": phone,
        "password": password,
      }),
    );

    return response;
  }

  static Future<http.Response> patientSignUp(
    String? phone,
    String? email,
    String? fullName,
    String? password,
    String? passwordConfirmation,
  ) async {
    var response = await client.post(
      Uri.parse("${baseUrl}register/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "phone": phone,
        "email": email,
        "full_name": fullName,
        "password": password,
        "password_confirmation": passwordConfirmation,
      }),
    );

    return response;
  }

  static Future<http.Response> activationOtp(String? token) async {
    String? phone = authProvider.allSignUpdetails.user!.phone;
    var response = await client.post(
      Uri.parse("${baseUrl}activate/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(
        {
          "phone": phone,
          "token": token,
        },
      ),
    );
    return response;
  }
}
