// To parse this JSON data, do
//
//     final reviewResponseModel = reviewResponseModelFromJson(jsonString);

import 'dart:convert';

ReviewResponseModel reviewResponseModelFromJson(String str) => ReviewResponseModel.fromJson(json.decode(str));

String reviewResponseModelToJson(ReviewResponseModel data) => json.encode(data.toJson());

class ReviewResponseModel {
  int currentPage;
  List<ReviewModel> reviews;
  String firstPageUrl;

  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int total;

  ReviewResponseModel({
    required this.currentPage,
    required this.reviews,
    required this.firstPageUrl,

    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,

    required this.total,
  });

  factory ReviewResponseModel.fromJson(Map<String, dynamic> json) => ReviewResponseModel(
    currentPage: json["current_page"],
    reviews: List<ReviewModel>.from(json["data"].map((x) => ReviewModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],

    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],

    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,

    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,

    "total": total,
  };
}

class ReviewModel {
  int id;
  int productId;
  int userId;
  int rate;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rate,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    rate: json["rate"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "rate": rate,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String picture;
  String phone;
  String email;
  dynamic birthdate;
  String gender;
  String role;
  String kycStatus;
  int isDeleted;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.picture,
    required this.phone,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.role,
    required this.kycStatus,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    phone: json["phone"],
    email: json["email"],
    birthdate: json["birthdate"],
    gender: json["gender"],
    role: json["role"],
    kycStatus: json["kyc_status"],
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
    "name": name,
    "picture": picture,
    "phone": phone,
    "email": email,
    "birthdate": birthdate,
    "gender": gender,
    "role": role,
    "kyc_status": kycStatus,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Link {
  String? url;
  String label;
  int? page;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.page,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    page: json["page"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "page": page,
    "active": active,
  };
}
