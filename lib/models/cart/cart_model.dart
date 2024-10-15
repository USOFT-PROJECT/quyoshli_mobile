// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  Data? data;

  CartModel({
    this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  ReadySolutions? readySolutions;
  ReadySolutions? singleProducts;

  Data({
    this.readySolutions,
    this.singleProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    readySolutions: json["ready_solutions"] == null ? null : ReadySolutions.fromJson(json["ready_solutions"]),
    singleProducts: json["single_products"] == null ? null : ReadySolutions.fromJson(json["single_products"]),
  );

  Map<String, dynamic> toJson() => {
    "ready_solutions": readySolutions?.toJson(),
    "single_products": singleProducts?.toJson(),
  };
}

class ReadySolutions {
  List<Product>? products;
  int? price;
  int? discount;
  int? total;

  ReadySolutions({
    this.products,
    this.price,
    this.discount,
    this.total,
  });

  factory ReadySolutions.fromJson(Map<String, dynamic> json) => ReadySolutions(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    price: json["price"],
    discount: json["discount"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "price": price,
    "discount": discount,
    "total": total,
  };
}

class Product {
  int? id;
  String? name;
  int? price;
  int? priceDiscount;
  int? priceTotal;
  dynamic discountPercent;
  String? poster;
  String? posterThumb;
  int? count;
  int? availableCount;
  bool? isAvailable;
  int? productId;

  Product({
    this.id,
    this.name,
    this.price,
    this.priceDiscount,
    this.priceTotal,
    this.discountPercent,
    this.poster,
    this.posterThumb,
    this.count,
    this.availableCount,
    this.isAvailable,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    priceDiscount: json["price_discount"],
    priceTotal: json["price_total"],
    discountPercent: json["discount_percent"],
    poster: json["poster"],
    posterThumb: json["poster_thumb"],
    count: json["count"],
    availableCount: json["available_count"],
    isAvailable: json["is_available"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "price_discount": priceDiscount,
    "price_total": priceTotal,
    "discount_percent": discountPercent,
    "poster": poster,
    "poster_thumb": posterThumb,
    "count": count,
    "available_count": availableCount,
    "is_available": isAvailable,
    "product_id": productId,
  };
}
