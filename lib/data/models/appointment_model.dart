import 'dart:convert';

List<Appointment?>? appointmentFromJson(String str) => json.decode(str) == null
    ? []
    : List<Appointment?>.from(
        json.decode(str)!.map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class Appointment {
  Appointment({
    this.id,
    this.patient,
    this.clinic,
    this.appointmentFee,
    this.appointmentDate,
    this.service,
    this.appointmentTime,
    this.appointmentType,
    this.receptionist,
    this.doctor,
    this.notes,
    this.findings,
    this.status,
    this.paid,
    this.yourMessage,
    this.phone,
  });

  int? id;
  AppointmentPatient? patient;
  int? clinic;
  int? appointmentFee;
  String? appointmentDate;
  int? service;
  String? appointmentTime;
  String? appointmentType;
  int? receptionist;
  int? doctor;
  String? notes;
  String? findings;
  String? status;
  bool? paid;
  String? yourMessage;
  String? phone;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        patient: AppointmentPatient.fromJson(json["patient"]),
        clinic: json["clinic"],
        appointmentFee: json["appointment_fee"],
        appointmentDate: json["appointment_date"],
        service: json["service"],
        appointmentTime: json["appointment_time"],
        appointmentType: json["appointment_type"],
        receptionist: json["receptionist"],
        doctor: json["doctor"],
        notes: json["notes"],
        findings: json["findings"],
        status: json["status"],
        paid: json["paid"],
        yourMessage: json["your_message"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient": patient!.toJson(),
        "clinic": clinic,
        "appointment_fee": appointmentFee,
        "appointment_date": appointmentDate,
        "service": service,
        "appointment_time": appointmentTime,
        "appointment_type": appointmentType,
        "receptionist": receptionist,
        "doctor": doctor,
        "notes": notes,
        "findings": findings,
        "status": status,
        "paid": paid,
        "your_message": yourMessage,
        "phone": phone,
      };
}

class AppointmentPatient {
  AppointmentPatient({
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
  AppointmentUser? user;
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
  int? weight;
  int? height;
  int? bloodPressure;
  int? bloodSugar;
  String? allergies;

  factory AppointmentPatient.fromJson(Map<String, dynamic> json) =>
      AppointmentPatient(
        id: json["id"],
        user: AppointmentUser.fromJson(json["user"]),
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

class AppointmentUser {
  AppointmentUser({
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

  factory AppointmentUser.fromJson(Map<String, dynamic> json) =>
      AppointmentUser(
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
