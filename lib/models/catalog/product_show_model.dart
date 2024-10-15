// To parse this JSON data, do
//
//     final productShowModel = productShowModelFromJson(jsonString);

import 'dart:convert';

ProductShowModel productShowModelFromJson(String str) => ProductShowModel.fromJson(json.decode(str));

String productShowModelToJson(ProductShowModel data) => json.encode(data.toJson());

class ProductShowModel {
  ShowProduct? data;

  ProductShowModel({
    this.data,
  });

  factory ProductShowModel.fromJson(Map<String, dynamic> json) => ProductShowModel(
    data: json["data"] == null ? null : ShowProduct.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ShowProduct {

  int? id;
  String? name;
  int? price;
  int? priceUsd;
  int? priceDiscountUsd;
  int? priceDiscount;
  int? discountPercent;
  bool? isLeaderOfSales;
  String? poster;
  String? posterThumb;
  bool? isFavorite;
  bool? isCart;
  bool? isAvailable;
  int? count;
  String? dataSheet;
  List<Screen>? screens;
  List<Characteristic>? characteristics;
  int? inCart;

  ShowProduct({
    this.id,
    this.name,
    this.price,
    this.priceUsd,
    this.priceDiscountUsd,
    this.priceDiscount,
    this.discountPercent,
    this.isLeaderOfSales,
    this.poster,
    this.posterThumb,
    this.isFavorite,
    this.isCart,
    this.isAvailable,
    this.count,
    this.dataSheet,
    this.screens,
    this.characteristics,
    this.inCart
  });

  factory ShowProduct.fromJson(Map<String, dynamic> json) => ShowProduct(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    priceUsd: json["price_usd"],
    priceDiscountUsd: json["price_discount_usd"],
    priceDiscount: json["price_discount"],
    discountPercent: json["discount_percent"],
    isLeaderOfSales: json["is_leader_of_sales"],
    poster: json["poster"],
    posterThumb: json["poster_thumb"],
    isFavorite: json["is_favorite"],
    isCart: json["is_cart"],
    isAvailable: json["is_available"],
    count: json["count"],
    dataSheet: json["data_sheet"],
    screens: json["screens"] == null ? [] : List<Screen>.from(json["screens"]!.map((x) => Screen.fromJson(x))),
    characteristics: json["characteristics"] == null ? [] : List<Characteristic>.from(json["characteristics"]!.map((x) => Characteristic.fromJson(x))),
    inCart: json["in_cart"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "price_usd": priceUsd,
    "price_discount_usd": priceDiscountUsd,
    "price_discount": priceDiscount,
    "discount_percent": discountPercent,
    "is_leader_of_sales": isLeaderOfSales,
    "poster": poster,
    "poster_thumb": posterThumb,
    "is_favorite": isFavorite,
    "is_cart": isCart,
    "is_available": isAvailable,
    "count": count,
    "data_sheet": dataSheet,
    "screens": screens == null ? [] : List<dynamic>.from(screens!.map((x) => x.toJson())),
    "characteristics": characteristics == null ? [] : List<dynamic>.from(characteristics!.map((x) => x.toJson())),
    "in_cart": inCart,
  };
}

class Characteristic {
  int? id;
  String? name;
  String? type;
  Pivot? pivot;

  Characteristic({
    this.id,
    this.name,
    this.type,
    this.pivot,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) => Characteristic(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  String? value;

  Pivot({
    this.value,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}

class Screen {
  int? id;
  String? path;
  String? pathThumb;

  Screen({
    this.id,
    this.path,
    this.pathThumb,
  });

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
    id: json["id"],
    path: json["path"],
    pathThumb: json["path_thumb"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "path_thumb": pathThumb,
  };
}
