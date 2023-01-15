import 'dart:convert';

List<ClinicAlbum?>? clinicAlbumFromJson(String str) => json.decode(str) == null
    ? []
    : List<ClinicAlbum?>.from(
        json.decode(str)!.map((x) => ClinicAlbum.fromJson(x)));

String clinicAlbumToJson(List<ClinicAlbum?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class ClinicAlbum {
  ClinicAlbum({
    this.id,
    this.clinic,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? clinic;
  String? image;
  String? createdAt;
  String? updatedAt;

  factory ClinicAlbum.fromJson(Map<String, dynamic> json) => ClinicAlbum(
        id: json["id"],
        clinic: json["clinic"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clinic": clinic,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
