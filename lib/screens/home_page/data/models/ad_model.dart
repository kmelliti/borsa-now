// To parse this JSON data, do
//
//     final adModel = adModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AdModel> adModelFromJson(String str) => List<AdModel>.from(json.decode(str).map((x) => AdModel.fromJson(x)));

String adModelToJson(List<AdModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdModel {
  int id;
  int retailListingId;
  dynamic picture;
  String discount;
  String message;
  DateTime adStartAt;
  DateTime adEndAt;
  DateTime createdAt;
  dynamic updatedAt;

  AdModel({
    required this.id,
    required this.retailListingId,
    required this.picture,
    required this.discount,
    required this.message,
    required this.adStartAt,
    required this.adEndAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
    id: json["id"],
    retailListingId: json["retail_listing_id"],
    picture: json["picture"],
    discount: json["discount"],
    message: json["message"],
    adStartAt: DateTime.parse(json["ad_start_at"]),
    adEndAt: DateTime.parse(json["ad_end_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "retail_listing_id": retailListingId,
    "picture": picture,
    "discount": discount,
    "message": message,
    "ad_start_at": adStartAt.toIso8601String(),
    "ad_end_at": adEndAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
