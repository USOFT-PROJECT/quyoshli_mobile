// To parse this JSON data, do
//
//     final favouriteProductsModel = favouriteProductsModelFromJson(jsonString);

import 'dart:convert';

FavouriteProductsModel favouriteProductsModelFromJson(String str) => FavouriteProductsModel.fromJson(json.decode(str));

String favouriteProductsModelToJson(FavouriteProductsModel data) => json.encode(data.toJson());

class FavouriteProductsModel {
  Pagination? pagination;
  List<FavouriteProductModel>? data;

  FavouriteProductsModel({
    this.pagination,
    this.data,
  });

  factory FavouriteProductsModel.fromJson(Map<String, dynamic> json) => FavouriteProductsModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<FavouriteProductModel>.from(json["data"]!.map((x) => FavouriteProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FavouriteProductModel {
  int? id;
  String? name;
  int? price;
  int? priceDiscount;
  int? discountPercent;
  bool? isLeaderOfSales;
  String? poster;
  String? posterThumb;
  bool? isFavorite;
  bool? isCart;

  FavouriteProductModel({
    this.id,
    this.name,
    this.price,
    this.priceDiscount,
    this.discountPercent,
    this.isLeaderOfSales,
    this.poster,
    this.posterThumb,
    this.isFavorite,
    this.isCart,
  });

  factory FavouriteProductModel.fromJson(Map<String, dynamic> json) => FavouriteProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    priceDiscount: json["price_discount"],
    discountPercent: json["discount_percent"],
    isLeaderOfSales: json["is_leader_of_sales"],
    poster: json["poster"],
    posterThumb: json["poster_thumb"],
    isFavorite: json["is_favorite"],
    isCart: json["is_cart"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "price_discount": priceDiscount,
    "discount_percent": discountPercent,
    "is_leader_of_sales": isLeaderOfSales,
    "poster": poster,
    "poster_thumb": posterThumb,
    "is_favorite": isFavorite,
    "is_cart": isCart,
  };
}

class Pagination {
  int? current;
  int? previous;
  int? next;
  int? perPage;
  int? totalPage;
  int? totalItem;

  Pagination({
    this.current,
    this.previous,
    this.next,
    this.perPage,
    this.totalPage,
    this.totalItem,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    current: json["current"],
    previous: json["previous"],
    next: json["next"],
    perPage: json["perPage"],
    totalPage: json["totalPage"],
    totalItem: json["totalItem"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "previous": previous,
    "next": next,
    "perPage": perPage,
    "totalPage": totalPage,
    "totalItem": totalItem,
  };
}
