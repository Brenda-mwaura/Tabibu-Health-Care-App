
import 'dart:convert';

List<ClinicMedicalService> clinicMedicalServiceFromJson(String str) => List<ClinicMedicalService>.from(json.decode(str).map((x) => ClinicMedicalService.fromJson(x)));

String clinicMedicalServiceToJson(List<ClinicMedicalService> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClinicMedicalService {
    ClinicMedicalService({
        this.id,
        this.clinic,
        this.service,
        this.price,
        this.available,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? clinic;
    int? service;
    double? price;
    bool? available;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory ClinicMedicalService.fromJson(Map<String, dynamic> json) => ClinicMedicalService(
        id: json["id"],
        clinic: json["clinic"],
        service: json["service"],
        price: json["price"],
        available: json["available"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clinic": clinic,
        "service": service,
        "price": price,
        "available": available,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
