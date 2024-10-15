// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  Pagination? pagination;
  List<Order>? data;

  OrderModel({
    this.pagination,
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Order {
  int? id;
  Status? status;
  DateTime? createdAt;
  int? totalAmount;

  Order({
    this.id,
    this.status,
    this.createdAt,
    this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "total_amount": totalAmount,
  };
}

class Status {
  String? slug;
  String? translation;
  String? fontColor;
  String? bgColor;

  Status({
    this.slug,
    this.translation,
    this.fontColor,
    this.bgColor,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    slug: json["slug"],
    translation: json["translation"],
    fontColor: json["font_color"],
    bgColor: json["bg_color"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "translation": translation,
    "font_color": fontColor,
    "bg_color": bgColor,
  };
}

class Pagination {
  int? current;
  dynamic previous;
  dynamic next;
  int? total;
  int? perPage;
  int? totalItems;

  Pagination({
    this.current,
    this.previous,
    this.next,
    this.total,
    this.perPage,
    this.totalItems,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    current: json["current"],
    previous: json["previous"],
    next: json["next"],
    total: json["total"],
    perPage: json["perPage"],
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "previous": previous,
    "next": next,
    "total": total,
    "perPage": perPage,
    "totalItems": totalItems,
  };
}
