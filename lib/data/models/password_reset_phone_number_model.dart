import 'dart:convert';

import 'package:hive/hive.dart';
part 'password_reset_phone_number_model.g.dart';

PasswordResetPhoneNumber passwordResetPhoneNumberFromJson(String str) =>
    PasswordResetPhoneNumber.fromJson(json.decode(str));

String passwordResetPhoneNumberToJson(PasswordResetPhoneNumber data) =>
    json.encode(data.toJson());

@HiveType(typeId: 4)
class PasswordResetPhoneNumber {
  PasswordResetPhoneNumber({
    this.data,
    this.message,
  });

  @HiveField(0)
  Data? data;
  @HiveField(1)
  String? message;

  factory PasswordResetPhoneNumber.fromJson(Map<String, dynamic> json) =>
      PasswordResetPhoneNumber(
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
