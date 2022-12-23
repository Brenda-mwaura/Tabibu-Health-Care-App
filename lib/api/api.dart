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

  static Future<http.Response> passwordResetPhoneNumber(
      String? phoneNumber) async {
    var response = await client.post(
      Uri.parse("${baseUrl}password-reset/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "phone": phoneNumber,
      }),
    );
    return response;
  }

  static Future<http.Response> passwordResetTokenCheck(String? token) async {
    String? phone = authProvider.passwordResetPhoneDetailsDb.data!.phone;

    var response = await client.post(
      Uri.parse("${baseUrl}password-reset-token-check/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "phone": phone,
        "token": token,
      }),
    );
    return response;
  }

  static Future<http.Response> passwordReset(
      String? password, String? passwordConfirm) async {
    String? phone = authProvider.otpCheckDetails.otpData!.phone;
    String? token = authProvider.otpCheckDetails.otpData!.token;

    var response = await client.post(
      Uri.parse("${baseUrl}password-reset-complete/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "password": password,
        "password_confirm": passwordConfirm,
        "phone": phone,
        "token": token,
      }),
    );
    return response;
  }

  static Future<http.Response> logout() async {
    String? refresh = authProvider.allLoginDetails.refresh;
    String? token = authProvider.allLoginDetails.access;
    var response = await client.post(
      Uri.parse("${baseUrl}logout/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "refresh": refresh,
      }),
    );

    return response;
  }

  static Future<http.Response> refreshToken(String? refreshToken) async {
    var response = await client.post(
      Uri.parse('${baseUrl}auth/refresh/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "refresh": refreshToken,
      }),
    );
    return response;
  }
}
