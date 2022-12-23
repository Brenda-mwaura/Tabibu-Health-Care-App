import 'dart:convert';

import 'package:hive/hive.dart';
part "profile_model.g.dart";

PatientProfile patientProfileFromJson(String str) =>
    PatientProfile.fromJson(json.decode(str));

String patientProfileToJson(PatientProfile data) => json.encode(data.toJson());

@HiveType(typeId: 8)
class PatientProfile {
  PatientProfile({
    this.id,
    this.user,
    this.bio,
    this.profilePicture,
    this.idNo,
    this.nationality,
    this.town,
    this.estate,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.timestamp,
    this.bloodGroup,
    this.weight,
    this.height,
    this.bloodPressure,
    this.bloodSugar,
    this.allergies,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  User? user;
  @HiveField(2)
  String? bio;
  @HiveField(3)
  String? profilePicture;
  @HiveField(4)
  String? idNo;
  @HiveField(5)
  String? nationality;
  @HiveField(6)
  String? town;
  @HiveField(7)
  String? estate;
  @HiveField(8)
  String? gender;
  @HiveField(9)
  String? maritalStatus;
  @HiveField(10)
  String? dateOfBirth;
  @HiveField(11)
  String? timestamp;
  @HiveField(12)
  String? bloodGroup;
  @HiveField(13)
  int? weight;
  @HiveField(14)
  int? height;
  @HiveField(15)
  int? bloodPressure;
  @HiveField(16)
  int? bloodSugar;
  @HiveField(17)
  String? allergies;

  factory PatientProfile.fromJson(Map<String, dynamic> json) => PatientProfile(
        id: json["id"],
        user: User.fromJson(json["user"]),
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        idNo: json["id_no"],
        nationality: json["nationality"],
        town: json["town"],
        estate: json["estate"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        dateOfBirth: json["date_of_birth"],
        timestamp: json["timestamp"],
        bloodGroup: json["blood_group"],
        weight: json["weight"],
        height: json["height"],
        bloodPressure: json["blood_pressure"],
        bloodSugar: json["blood_sugar"],
        allergies: json["allergies"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "bio": bio,
        "profile_picture": profilePicture,
        "id_no": idNo,
        "nationality": nationality,
        "town": town,
        "estate": estate,
        "gender": gender,
        "marital_status": maritalStatus,
        "date_of_birth": dateOfBirth,
        "timestamp": timestamp,
        "blood_group": bloodGroup,
        "weight": weight,
        "height": height,
        "blood_pressure": bloodPressure,
        "blood_sugar": bloodSugar,
        "allergies": allergies,
      };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
