import 'dart:convert';

Specialization? specializationFromJson(String str) =>
    Specialization.fromJson(json.decode(str));

String specializationToJson(Specialization? data) =>
    json.encode(data!.toJson());

class Specialization {
  Specialization({
    this.id,
    this.specialization,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? specialization;
  String? createdAt;
  String? updatedAt;

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["id"],
        specialization: json["specialization"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "specialization": specialization,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
      