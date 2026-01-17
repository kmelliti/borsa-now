// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'dart:convert';

List<FavouriteModel> favouriteModelFromJson(String str) => List<FavouriteModel>.from(json.decode(str).map((x) => FavouriteModel.fromJson(x)));

String favouriteModelToJson(List<FavouriteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteModel {
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

  FavouriteModel({
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

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
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
  dynamic avgRate;
  List<ProductPicture> productPictures;

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
    required this.avgRate,
    required this.productPictures,
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
    avgRate: json["avg_rate"],
    productPictures: List<ProductPicture>.from(json["product_pictures"].map((x) => ProductPicture.fromJson(x))),
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
    "avg_rate": avgRate,
    "product_pictures": List<dynamic>.from(productPictures.map((x) => x.toJson())),
  };
}

class ProductPicture {
  int id;
  int productId;
  String picture;
  DateTime createdAt;
  DateTime updatedAt;

  ProductPicture({
    required this.id,
    required this.productId,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
    id: json["id"],
    productId: json["product_id"],
    picture: json["picture"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "picture": picture,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
