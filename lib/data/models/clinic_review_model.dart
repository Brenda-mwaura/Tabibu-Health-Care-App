import 'dart:convert';

List<ClinicReview?>? clinicReviewFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<ClinicReview?>.from(
            json.decode(str)!.map((x) => ClinicReview.fromJson(x)));

String clinicReviewToJson(List<ClinicReview?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ClinicReview {
  ClinicReview({
    this.id,
    this.clinic,
    this.rating,
    this.patient,
    this.comment,
    this.flag,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? clinic;
  double? rating;
  ReviewingPatient? patient;
  String? comment;
  bool? flag;
  String? createdAt;
  String? updatedAt;

  factory ClinicReview.fromJson(Map<String, dynamic> json) => ClinicReview(
        id: json["id"],
        clinic: json["clinic"],
        rating: json["rating"],
        patient: ReviewingPatient.fromJson(json["patient"]),
        comment: json["comment"],
        flag: json["flag"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clinic": clinic,
        "rating": rating,
        "patient": patient!.toJson(),
        "comment": comment,
        "flag": flag,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class ReviewingPatient {
  ReviewingPatient({
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

  int? id;
  ReviewingUser? user;
  String? bio;
  String? profilePicture;
  String? idNo;
  String? nationality;
  String? town;
  String? estate;
  String? gender;
  String? maritalStatus;
  String? dateOfBirth;
  String? timestamp;
  String? bloodGroup;
  double? weight;
  double? height;
  double? bloodPressure;
  double? bloodSugar;
  String? allergies;

  factory ReviewingPatient.fromJson(Map<String, dynamic> json) =>
      ReviewingPatient(
        id: json["id"],
        user: ReviewingUser.fromJson(json["user"]),
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

class ReviewingUser {
  ReviewingUser({
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

  factory ReviewingUser.fromJson(Map<String, dynamic> json) => ReviewingUser(
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
