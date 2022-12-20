import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.refresh,
    this.access,
    this.user,
  });

  String? refresh;
  String? access;
  LoggedInUser? user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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

  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  bool? isActive;
  String? updatedAt;
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
