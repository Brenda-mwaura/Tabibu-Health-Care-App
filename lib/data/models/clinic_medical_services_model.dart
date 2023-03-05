import 'dart:convert';

List<ClinicMedicalServices> clinicMedicalServicesFromJson(String str) => List<ClinicMedicalServices>.from(json.decode(str).map((x) => ClinicMedicalServices.fromJson(x)));

String clinicMedicalServicesToJson(List<ClinicMedicalServices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClinicMedicalServices {
    ClinicMedicalServices({
        this.id,
        this.clinic,
        this.services,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? clinic;
    List<int>? services;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory ClinicMedicalServices.fromJson(Map<String, dynamic> json) => ClinicMedicalServices(
        id: json["id"],
        clinic: json["clinic"],
        services: List<int>.from(json["services"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clinic": clinic,
        "services": List<dynamic>.from(services!.map((x) => x)),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
