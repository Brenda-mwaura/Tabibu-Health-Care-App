import 'dart:convert';

import 'package:hive/hive.dart';
part 'otp_check_model.g.dart';

TokenCheck tokenCheckFromJson(String str) =>
    TokenCheck.fromJson(json.decode(str));

String tokenCheckToJson(TokenCheck data) => json.encode(data.toJson());

@HiveType(typeId: 4)
class TokenCheck {
  TokenCheck({
    this.data,
    this.message,
  });

  @HiveField(0)
  Data? data;
  @HiveField(1)
  String? message;

  factory TokenCheck.fromJson(Map<String, dynamic> json) => TokenCheck(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
      };
}

@HiveType(typeId: 5)
class Data {
  Data({
    this.phone,
  });

  @HiveField(0)
  String? phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
