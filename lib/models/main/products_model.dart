// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  List<ProductList>? data;

  ProductListModel({
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        data: json["data"] == null
            ? []
            : List<ProductList>.from(
                json["data"]!.map((x) => ProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductList {
  int? id;
  String? title;
  List<Product>? products;

  ProductList({
    this.id,
    this.title,
    this.products,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["id"],
        title: json["title"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? name;
  int? price;
  int? priceDiscount;
  dynamic discountPercent;
  bool? isLeaderOfSales;
  String? poster;
  String? posterThumb;
  bool? isFavorite;
  bool? isCart;

  int currentPrice() => (price ?? 0) - (priceDiscount ?? 0);

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
