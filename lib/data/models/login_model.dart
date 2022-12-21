import 'dart:convert';

import 'package:hive/hive.dart';
part 'login_model.g.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class Login {
  Login({
    this.refresh,
    this.access,
    this.user,
  });

  @HiveField(0)
  String? refresh;
  @HiveField(1)
  String? access;
  @HiveField(2)
  LoggedInUser? user;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        refresh: json["refresh"],
        access: json["access"],
        user: LoggedInUser.fromJson(json["LoggedInUser"]),
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "user": user!.toJson(),
      };
}

@HiveType(typeId: 1)
class LoggedInUser {
  LoggedInUser({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.role,
    this.isActive,
    this.updatedAt,
    this.timestamp,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? role;
  @HiveField(5)
  bool? isActive;
  @HiveField(6)
  String? updatedAt;
  @HiveField(7)
  String? timestamp;

  factory LoggedInUser.fromJson(Map<String, dynamic> json) => LoggedInUser(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        isActive: json["is_active"],
        updatedAt: json["updated_at"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "role": role,
        "is_active": isActive,
        "updated_at": updatedAt,
        "timestamp": timestamp,
      };
}
