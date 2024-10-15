// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import '../main/products_model.dart';

CartProductModel productModelFromJson(String str) => CartProductModel.fromJson(json.decode(str));

String productModelToJson(CartProductModel data) => json.encode(data.toJson());

class CartProductModel {
  Pagination? pagination;
  List<Product>? data;

  CartProductModel({
    this.pagination,
    this.data,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
