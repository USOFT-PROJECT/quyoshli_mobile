// To parse this JSON data, do
//
//     final brandListModel = brandListModelFromJson(jsonString);

import 'dart:convert';

BrandListModel brandListModelFromJson(String str) => BrandListModel.fromJson(json.decode(str));

String brandListModelToJson(BrandListModel data) => json.encode(data.toJson());

class BrandListModel {
  Pagination? pagination;
  List<BrandModel>? data;

  BrandListModel({
    this.pagination,
    this.data,
  });

  factory BrandListModel.fromJson(Map<String, dynamic> json) => BrandListModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<BrandModel>.from(json["data"]!.map((x) => BrandModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BrandModel {
  int? id;
  String? name;
  String? image;
  dynamic slug;

  BrandModel({
    this.id,
    this.name,
    this.image,
    this.slug,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
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
