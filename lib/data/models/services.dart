import 'dart:convert';

List<Services?>? servicesFromJson(String str) => json.decode(str) == null
    ? []
    : List<Services?>.from(json.decode(str)!.map((x) => Services.fromJson(x)));

String servicesToJson(List<Services?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Services {
  Services({
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
  int? price;
  String? createdAt;
  String? updatedAt;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
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
