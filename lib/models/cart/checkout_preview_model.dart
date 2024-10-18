// To parse this JSON data, do
//
//     final checkoutPreviewResponseModel = checkoutPreviewResponseModelFromJson(jsonString);

import 'dart:convert';

CheckoutPreviewResponseModel checkoutPreviewResponseModelFromJson(String str) =>
    CheckoutPreviewResponseModel.fromJson(json.decode(str));

String checkoutPreviewResponseModelToJson(CheckoutPreviewResponseModel data) =>
    json.encode(data.toJson());

class CheckoutPreviewResponseModel {
  CheckoutPreviewData? data;

  CheckoutPreviewResponseModel({this.data});

  factory CheckoutPreviewResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckoutPreviewResponseModel(
        data: json["data"] == null
            ? null
            : CheckoutPreviewData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CheckoutPreviewData {
  List<CheckoutPreviewProduct>? products;
  int? deliveryPrice;
  int? installationPrice;
  int? totalPrice;
  int? productPrice;

  CheckoutPreviewData({
    this.products,
    this.deliveryPrice,
    this.installationPrice,
    this.totalPrice,
    this.productPrice,
  });

  factory CheckoutPreviewData.fromJson(Map<String, dynamic> json) =>
      CheckoutPreviewData(
        products: json["products"] == null
            ? []
            : List<CheckoutPreviewProduct>.from(json["products"]!
                .map((x) => CheckoutPreviewProduct.fromJson(x))),
        deliveryPrice: json["delivery_price"],
        installationPrice: json["installation_price"],
        totalPrice: json["total_price"],
        productPrice: json["product_price"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "delivery_price": deliveryPrice,
        "installation_price": installationPrice,
        "total_price": totalPrice,
        "product_price": productPrice,
      };
}

class CheckoutPreviewProduct {
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
  int? count;

  CheckoutPreviewProduct({
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
    this.count,
  });

  factory CheckoutPreviewProduct.fromJson(Map<String, dynamic> json) =>
      CheckoutPreviewProduct(
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
        count: json["count"],
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
        "count": count,
      };
}
