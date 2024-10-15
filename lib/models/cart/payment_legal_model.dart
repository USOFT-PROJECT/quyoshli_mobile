// To parse this JSON data, do
//
//     final paymentSystemsLegal = paymentSystemsLegalFromJson(jsonString);

import 'dart:convert';

PaymentSystemsLegal paymentSystemsLegalFromJson(String str) => PaymentSystemsLegal.fromJson(json.decode(str));

String paymentSystemsLegalToJson(PaymentSystemsLegal data) => json.encode(data.toJson());

class PaymentSystemsLegal {
  PaymentSystem? data;

  PaymentSystemsLegal({
    this.data,
  });

  factory PaymentSystemsLegal.fromJson(Map<String, dynamic> json) => PaymentSystemsLegal(
    data: json["data"] == null ? null : PaymentSystem.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class PaymentSystem {
  List<PaymentType>? paymentTypes;

  PaymentSystem({
    this.paymentTypes,
  });

  factory PaymentSystem.fromJson(Map<String, dynamic> json) => PaymentSystem(
    paymentTypes: json["payment_types"] == null ? [] : List<PaymentType>.from(json["payment_types"]!.map((x) => PaymentType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "payment_types": paymentTypes == null ? [] : List<dynamic>.from(paymentTypes!.map((x) => x.toJson())),
  };
}

class PaymentType {
  String? title;
  List<System>? systems;

  PaymentType({
    this.title,
    this.systems,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
    title: json["title"],
    systems: json["systems"] == null ? [] : List<System>.from(json["systems"]!.map((x) => System.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "systems": systems == null ? [] : List<dynamic>.from(systems!.map((x) => x.toJson())),
  };
}

class System {
  String? title;
  String? logo;
  String? slug;
  String? description;

  System({
    this.title,
    this.logo,
    this.slug,
    this.description,
  });

  factory System.fromJson(Map<String, dynamic> json) => System(
    title: json["title"],
    logo: json["logo"],
    slug: json["slug"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "logo": logo,
    "slug": slug,
    "description": description,
  };
}
