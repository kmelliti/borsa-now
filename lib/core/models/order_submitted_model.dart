// To parse this JSON data, do
//
//     final orderSubmittedModel = orderSubmittedModelFromJson(jsonString);

import 'dart:convert';

OrderSubmittedModel orderSubmittedModelFromJson(String str) => OrderSubmittedModel.fromJson(json.decode(str));

String orderSubmittedModelToJson(OrderSubmittedModel data) => json.encode(data.toJson());

class OrderSubmittedModel {
  int customerId;
  int amountTotal;
  String status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  List<Item> items;

  OrderSubmittedModel({
    required this.customerId,
    required this.amountTotal,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.items,
  });

  factory OrderSubmittedModel.fromJson(Map<String, dynamic> json) => OrderSubmittedModel(
    customerId: json["customer_id"],
    amountTotal: json["amount_total"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "amount_total": amountTotal,
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
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

  Item({
    required this.id,
    required this.orderId,
    required this.listingId,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    listingId: json["listing_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "listing_id": listingId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
