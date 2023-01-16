import 'dart:convert';

List<ClinicReview?>? clinicReviewFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<ClinicReview?>.from(
            json.decode(str)!.map((x) => ClinicReview.fromJson(x)));

String clinicReviewToJson(List<ClinicReview?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

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
  int? patient;
  String? comment;
  bool? flag;
  String? createdAt;
  String? updatedAt;

  factory ClinicReview.fromJson(Map<String, dynamic> json) => ClinicReview(
        id: json["id"],
        clinic: json["clinic"],
        rating: json["rating"],
        patient: json["patient"],
        comment: json["comment"],
        flag: json["flag"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clinic": clinic,
        "rating": rating,
        "patient": patient,
        "comment": comment,
        "flag": flag,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
