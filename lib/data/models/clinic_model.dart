import 'dart:convert';

List<Clinic> clinicFromJson(String str) =>
    List<Clinic>.from(json.decode(str).map((x) => Clinic.fromJson(x)));

String clinicToJson(List<Clinic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Clinic {
  Clinic({
    this.id,
    this.clinicName,
    this.email,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.description,
    this.openingHours,
    this.closingHours,
    this.verified,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? clinicName;
  String? email;
  String? address;
  String? phone;
  double? latitude;
  double? longitude;
  String? description;
  String? openingHours;
  String? closingHours;
  bool? verified;
  String? createdAt;
  String? updatedAt;

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        id: json["id"],
        clinicName: json["clinic_name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        description: json["description"],
        openingHours: json["opening_hours"],
        closingHours: json["closing_hours"],
        verified: json["verified"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clinic_name": clinicName,
        "email": email,
        "address": address,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
        "opening_hours": openingHours,
        "closing_hours": closingHours,
        "verified": verified,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
