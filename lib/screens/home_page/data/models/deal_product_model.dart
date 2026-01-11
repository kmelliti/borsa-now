// // To parse this JSON data, do
// //
// //     final dealProductModel = dealProductModelFromJson(jsonString);
//
// import 'dart:convert';
//
// DealProductModel dealProductModelFromJson(String str) => DealProductModel.fromJson(json.decode(str));
//
// String dealProductModelToJson(DealProductModel data) => json.encode(data.toJson());
//
// class DealProductModel {
//   int id;
//   int merchantId;
//   int productId;
//   int quantity;
//   int quantitySold;
//   String wholesalePrice;
//   String retailPrice;
//   dynamic minInvestment;
//   String totalInvested;
//   String targetAmount;
//   String status;
//   dynamic offerStartAt;
//   dynamic offerEndAt;
//   int isDeleted;
//   dynamic deletedAt;
//   int createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   DateTime createdAt;
//   DateTime updatedAt;
//   bool isFavorite;
//   PModel product;
//   double? rating;
//
//   DealProductModel({
//     required this.id,
//     required this.merchantId,
//     required this.productId,
//     required this.quantity,
//     required this.quantitySold,
//     required this.wholesalePrice,
//     required this.retailPrice,
//     required this.minInvestment,
//     required this.totalInvested,
//     required this.targetAmount,
//     required this.status,
//     required this.offerStartAt,
//     required this.offerEndAt,
//     required this.isDeleted,
//     required this.deletedAt,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.deletedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isFavorite,
//     required this.product,
//     // required this.rating,
//   });
//
//   factory DealProductModel.fromJson(Map<String, dynamic> json) => DealProductModel(
//     id: json["id"],
//     merchantId: json["merchant_id"],
//     productId: json["product_id"],
//     quantity: json["quantity"],
//     quantitySold: json["quantity_sold"],
//     wholesalePrice: json["wholesale_price"],
//     retailPrice: json["retail_price"],
//     minInvestment: json["min_investment"],
//     totalInvested: json["total_invested"],
//     targetAmount: json["target_amount"],
//     status: json["status"],
//     offerStartAt: json["offer_start_at"],
//     offerEndAt: json["offer_end_at"],
//     isDeleted: json["is_deleted"],
//     deletedAt: json["deleted_at"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     deletedBy: json["deleted_by"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     isFavorite: json["is_favorite"],
//     product: PModel.fromJson(json["product"]),
//     // rating: json["rating"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "merchant_id": merchantId,
//     "product_id": productId,
//     "quantity": quantity,
//     "quantity_sold": quantitySold,
//     "wholesale_price": wholesalePrice,
//     "retail_price": retailPrice,
//     "min_investment": minInvestment,
//     "total_invested": totalInvested,
//     "target_amount": targetAmount,
//     "status": status,
//     "offer_start_at": offerStartAt,
//     "offer_end_at": offerEndAt,
//     "is_deleted": isDeleted,
//     "deleted_at": deletedAt,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "deleted_by": deletedBy,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "is_favorite": isFavorite,
//     "product": product.toJson(),
//   };
// }
//
// class PModel {
//   int id;
//   int merchantId;
//   int productCategorieId;
//   String sku;
//   String name;
//   String description;
//   String costBasis;
//   int isDeleted;
//
//   int createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   DateTime createdAt;
//   DateTime updatedAt;
//   List<ProductPicture> productPictures;
//   List<Rates> rates;
//
//   PModel({
//     required this.id,
//     required this.merchantId,
//     required this.productCategorieId,
//     required this.sku,
//     required this.name,
//     required this.description,
//     required this.costBasis,
//     required this.isDeleted,
//
//     required this.createdBy,
//     required this.updatedBy,
//     required this.deletedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productPictures,
//     required this.rates,
//   });
//
//   factory PModel.fromJson(Map<String, dynamic> json) => PModel(
//     id: json["id"],
//     merchantId: json["merchant_id"],
//     productCategorieId: json["product_categorie_id"],
//     sku: json["sku"],
//     name: json["name"],
//     description: json["description"],
//     costBasis: json["cost_basis"],
//     isDeleted: json["is_deleted"],
//
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     deletedBy: json["deleted_by"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     productPictures: List<ProductPicture>.from(json["product_pictures"].map((x) => ProductPicture.fromJson(x))),
//     rates: List<Rates>.from(json["rates"].map((x) => Rates.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "merchant_id": merchantId,
//     "product_categorie_id": productCategorieId,
//     "sku": sku,
//     "name": name,
//     "description": description,
//     "cost_basis": costBasis,
//     "is_deleted": isDeleted,
//
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "deleted_by": deletedBy,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "product_pictures": List<dynamic>.from(productPictures.map((x) => x.toJson())),
//     "rates": List<dynamic>.from(rates.map((x) => x.toJson())),
//   };
// }
//
// class ProductPicture {
//   int id;
//   int productId;
//   String picture;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   ProductPicture({
//     required this.id,
//     required this.productId,
//     required this.picture,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
//     id: json["id"],
//     productId: json["product_id"],
//     picture: json["picture"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "picture": picture,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }





// To parse this JSON data, do
//
//     final dealProductModel = dealProductModelFromJson(jsonString);

import 'dart:convert';

List<DealProductModel> dealProductModelFromJson(String str) => List<DealProductModel>.from(json.decode(str).map((x) => DealProductModel.fromJson(x)));

String dealProductModelToJson(List<DealProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealProductModel {
  int id;
  int inventoryLotId;
  int productId;
  String retailPrice;
  dynamic discountPrice;
  int availableQuantity;
  int minPurchaseQty;
  dynamic availableFrom;
  dynamic availableUntil;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  bool isFavorite;
  Product product;
  int cartQuantity = 1;

  DealProductModel({
    required this.id,
    required this.inventoryLotId,
    required this.productId,
    required this.retailPrice,
    required this.discountPrice,
    required this.availableQuantity,
    required this.minPurchaseQty,
    required this.availableFrom,
    required this.availableUntil,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    required this.product,
  });

  factory DealProductModel.fromJson(Map<String, dynamic> json) => DealProductModel(
    id: json["id"],
    inventoryLotId: json["inventory_lot_id"],
    productId: json["product_id"],
    retailPrice: json["retail_price"],
    discountPrice: json["discount_price"],
    availableQuantity: json["available_quantity"],
    minPurchaseQty: json["min_purchase_qty"],
    availableFrom: json["available_from"],
    availableUntil: json["available_until"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isFavorite: json["is_favorite"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inventory_lot_id": inventoryLotId,
    "product_id": productId,
    "retail_price": retailPrice,
    "discount_price": discountPrice,
    "available_quantity": availableQuantity,
    "min_purchase_qty": minPurchaseQty,
    "available_from": availableFrom,
    "available_until": availableUntil,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_favorite": isFavorite,
    "product": product.toJson(),
  };
}

class Product {
  int id;
  int merchantId;
  int productCategorieId;
  String sku;
  String name;
  String description;
  String costBasis;
  int isDeleted;
  dynamic deletedAt;
  int createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductPicture> productPictures;
  List<Rates> rates;

  Product({
    required this.id,
    required this.merchantId,
    required this.productCategorieId,
    required this.sku,
    required this.name,
    required this.description,
    required this.costBasis,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.productPictures,
    required this.rates,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    merchantId: json["merchant_id"],
    productCategorieId: json["product_categorie_id"],
    sku: json["sku"],
    name: json["name"],
    description: json["description"],
    costBasis: json["cost_basis"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productPictures: List<ProductPicture>.from(json["product_pictures"].map((x) => ProductPicture.fromJson(x))),
    rates: List<Rates>.from(json["rates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "product_categorie_id": productCategorieId,
    "sku": sku,
    "name": name,
    "description": description,
    "cost_basis": costBasis,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_pictures": List<dynamic>.from(productPictures.map((x) => x.toJson())),
    "rates": List<dynamic>.from(rates.map((x) => x)),
  };
}

class ProductPicture {
  int? id;
  int? productId;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductPicture({
    this.id,
    this.productId,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
    id: json["id"],
    productId: json["product_id"],
    picture: json["picture"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "picture": picture,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Rates {
  int? id;
  int? productId;
  int? userId;
  int? rate;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rates({
    this.id,
    this.productId,
    this.userId,
    this.rate,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    rate: json["rate"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "rate": rate,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}