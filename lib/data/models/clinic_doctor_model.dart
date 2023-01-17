import 'dart:convert';

List<ClinicDoctor?>? clinicDoctorFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<ClinicDoctor?>.from(
            json.decode(str)!.map((x) => ClinicDoctor.fromJson(x)));

String clinicDoctorToJson(List<ClinicDoctor?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class ClinicDoctor {
  ClinicDoctor({
    this.id,
    this.user,
    this.jobId,
    this.available,
    this.bio,
    this.profilePicture,
    this.idNo,
    this.nationality,
    this.town,
    this.estate,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.clinic,
    this.verified,
    this.specialization,
    this.timestamp,
  });

  int? id;
  DoctorUser? user;
  String? jobId;
  bool? available;
  String? bio;
  String? profilePicture;
  String? idNo;
  String? nationality;
  String? town;
  String? estate;
  String? gender;
  String? maritalStatus;
  String? dateOfBirth;
  int? clinic;
  bool? verified;
  int? specialization;
  String? timestamp;

  factory ClinicDoctor.fromJson(Map<String, dynamic> json) => ClinicDoctor(
        id: json["id"],
        user: DoctorUser.fromJson(json["user"]),
        jobId: json["job_id"],
        available: json["available"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        idNo: json["id_no"],
        nationality: json["nationality"],
        town: json["town"],
        estate: json["estate"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        dateOfBirth: json["date_of_birth"],
        clinic: json["clinic"],
        verified: json["verified"],
        specialization: json["specialization"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "job_id": jobId,
        "available": available,
        "bio": bio,
        "profile_picture": profilePicture,
        "id_no": idNo,
        "nationality": nationality,
        "town": town,
        "estate": estate,
        "gender": gender,
        "marital_status": maritalStatus,
        "date_of_birth": dateOfBirth,
        "clinic": clinic,
        "verified": verified,
        "specialization": specialization,
        "timestamp": timestamp,
      };
}

class DoctorUser {
  DoctorUser({
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

  factory DoctorUser.fromJson(Map<String, dynamic> json) => DoctorUser(
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
