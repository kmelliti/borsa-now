// To parse this JSON data, do
//
//     final myOrderModel = myOrderModelFromJson(jsonString);

import 'dart:convert';

List<MyOrderModel> myOrderModelFromJson(String str) => List<MyOrderModel>.from(json.decode(str).map((x) => MyOrderModel.fromJson(x)));

String myOrderModelToJson(List<MyOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyOrderModel {
  int id;
  int customerId;
  String amountTotal;
  String status;
  dynamic paymentMethod;
  dynamic paidAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<MyOrderItem> items;

  MyOrderModel({
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

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
    id: json["id"],
    customerId: json["customer_id"],
    amountTotal: json["amount_total"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    paidAt: json["paid_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    items: List<MyOrderItem>.from(json["items"].map((x) => MyOrderItem.fromJson(x))),
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

class MyOrderItem {
  int id;
  int orderId;
  int listingId;
  int quantity;
  String unitPrice;
  DateTime createdAt;
  DateTime updatedAt;

  MyOrderItem({
    required this.id,
    required this.orderId,
    required this.listingId,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyOrderItem.fromJson(Map<String, dynamic> json) => MyOrderItem(
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
