// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:tabibu/api/interceptors/authorization_interceptor.dart';
import 'package:tabibu/app_config.dart';
import 'package:tabibu/providers/auth_provider.dart';

class Api {
  static var baseUrl = AppConfig.appUrl;
  static var client = http.Client();

  static final client2 = InterceptedClient.build(
    interceptors: [
      AuthorizationInterceptor(),
    ],
    requestTimeout: const Duration(seconds: 5),
  );

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

  static Future<http.Response> profile() async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}patient/profile/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future updateProfilePicture(
      String? imagePath, File? profileImage, int? userID) async {
    String? token = authProvider.allLoginDetails.access;
    final file = File(imagePath!);

    var request = http.MultipartRequest(
      "PUT",
      Uri.parse("${baseUrl}patient/profile/$userID/"),
    );

    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        "profile_picture",
        file.readAsBytesSync(),
        filename: imagePath.split('/').last,
      ),
    );

    var response = await request.send();
    return response;
  }

  static Future<http.Response> updateProfile(String? phone, String? email,
      String? fullName, String? bio, int? userID, String? dateOfBirth) async {
    String? token = authProvider.allLoginDetails.access;

    var response = await client2.put(
      Uri.parse("${baseUrl}patient/profile/$userID/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode({
        "user": {
          "full_name": fullName,
          "phone": phone,
          "email": email,
        },
        "bio": bio,
        "date_of_birth": dateOfBirth,
      }),
    );

    return response;
  }

  static Future<http.Response> clinics() async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}clinics/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future<http.Response> clinicAlbum(int? clinicID) async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}clinic/albums/${clinicID}/photos/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future<http.Response> clinicReview() async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}clinic/reviews/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future<http.Response> clinicDoctors() async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}doctors/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future<http.Response> doctorSpecialization(
      int? specializationID) async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}specialization/$specializationID"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future<http.Response> appointmentBooking(
      int? clinicID,
      String? appointmentDate,
      String? appointmentTime,
      int? serviceID,
      String? paymentPhoneNumber,
      String? yourMessage) async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.post(
      Uri.parse("${baseUrl}appointment/booking/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode({
        "clinic": clinicID,
        "appointment_date": appointmentDate,
        "appointment_time": appointmentTime,
        "service": serviceID,
        "phone": paymentPhoneNumber,
        "your_message": yourMessage
      }),
    );

    return response;
  }

  static Future<http.Response> clinicServices() async {
    String? accessToken = authProvider.allLoginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}services/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    return response;
  }
}
