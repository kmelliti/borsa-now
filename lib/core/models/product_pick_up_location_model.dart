// To parse this JSON data, do
//
//     final productPickUpLocation = productPickUpLocationFromJson(jsonString);

import 'dart:convert';

List<ProductPickUpLocation> productPickUpLocationFromJson(String str) => List<ProductPickUpLocation>.from(json.decode(str).map((x) => ProductPickUpLocation.fromJson(x)));

String productPickUpLocationToJson(List<ProductPickUpLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductPickUpLocation {
  int id;
  int merchantId;
  int cityId;
  String address;
  String latitude;
  String longitude;
  int isDeleted;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  ProductPickUpLocation({
    required this.id,
    required this.merchantId,
    required this.cityId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPickUpLocation.fromJson(Map<String, dynamic> json) => ProductPickUpLocation(
    id: json["id"],
    merchantId: json["merchant_id"],
    cityId: json["city_id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "city_id": cityId,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}
