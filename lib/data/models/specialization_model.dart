import 'dart:convert';

List<Specialization?>? specializationFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<Specialization?>.from(
            json.decode(str)!.map((x) => Specialization.fromJson(x)));

String specializationToJson(List<Specialization?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

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
        updatedAt:json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "specialization": specialization,
        "created_at": createdAt?,
        "updated_at": updatedAt?,
      };
}
