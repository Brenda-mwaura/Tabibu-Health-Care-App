import 'dart:convert';

List<ClinicServices?>? clinicServicesFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<ClinicServices?>.from(
            json.decode(str)!.map((x) => ClinicServices.fromJson(x)));

String clinicServicesToJson(List<ClinicServices?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ClinicServices {
  ClinicServices({
    this.id,
    this.serviceName,
    this.description,
    this.available,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? serviceName;
  String? description;
  bool? available;
  double? price;
  String? createdAt;
  String? updatedAt;

  factory ClinicServices.fromJson(Map<String, dynamic> json) => ClinicServices(
        id: json["id"],
        serviceName: json["service_name"],
        description: json["description"],
        available: json["available"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "description": description,
        "available": available,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
