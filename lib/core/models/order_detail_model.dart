// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
  int id;
  int customerId;
  String amountTotal;
  String status;
  dynamic paymentMethod;
  dynamic paidAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Item> items;

  OrderDetailModel({
    required this.id,
    required this.customerId,
    required this.amountTotal,
    required this.status,
    required this.paymentMethod,
    required this.paidAt,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
    id: json["id"],
    customerId: json["customer_id"],
    amountTotal: json["amount_total"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    paidAt: json["paid_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "amount_total": amountTotal,
    "status": status,
    "payment_method": paymentMethod,
    "paid_at": paidAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  int orderId;
  int listingId;
  int quantity;
  String unitPrice;
  DateTime createdAt;
  DateTime updatedAt;
  RetailListing retailListing;

  Item({
    required this.id,
    required this.orderId,
    required this.listingId,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.retailListing,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    listingId: json["listing_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    retailListing: RetailListing.fromJson(json["retail_listing"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "listing_id": listingId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "retail_listing": retailListing.toJson(),
  };
}

class RetailListing {
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
  Product product;

  RetailListing({
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
    required this.product,
  });

  factory RetailListing.fromJson(Map<String, dynamic> json) => RetailListing(
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
