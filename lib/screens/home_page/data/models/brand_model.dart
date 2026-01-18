import 'dart:convert';

List<BrandModel> brandModelFromJson(String str) => List<BrandModel>.from(json.decode(str).map((x) => BrandModel.fromJson(x)));

String brandModelToJson(List<BrandModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandModel {
  int id;
  int userId;
  int categoryId;
  String companyName;
  String? picture;
  String tradeLicenseNumber;
  String address;
  String? taxCertificate;
  String? copyTradeLicense;
  String? linkTiktok;
  String? linkInstagram;
  String? linkFacebook;
  String? linkX;
  int isActive;
  int isDeleted;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  bool selected = false;

  BrandModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.companyName,
    required this.picture,
    required this.tradeLicenseNumber,
    required this.address,
    required this.taxCertificate,
    required this.copyTradeLicense,
    required this.linkTiktok,
    required this.linkInstagram,
    required this.linkFacebook,
    required this.linkX,
    required this.isActive,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    companyName: json["company_name"],
    picture: json["picture"],
    tradeLicenseNumber: json["trade_license_number"],
    address: json["address"],
    taxCertificate: json["tax_certificate"],
    copyTradeLicense: json["copy_trade_license"],
    linkTiktok: json["link_tiktok"],
    linkInstagram: json["link_instagram"],
    linkFacebook: json["link_facebook"],
    linkX: json["link_x"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "company_name": companyName,
    "picture": picture,
    "trade_license_number": tradeLicenseNumber,
    "address": address,
    "tax_certificate": taxCertificate,
    "copy_trade_license": copyTradeLicense,
    "link_tiktok": linkTiktok,
    "link_instagram": linkInstagram,
    "link_facebook": linkFacebook,
    "link_x": linkX,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}