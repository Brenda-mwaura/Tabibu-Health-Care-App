import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tabibu/app_config.dart';

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

    print("Response.... $response");
    return response;
  }
}
