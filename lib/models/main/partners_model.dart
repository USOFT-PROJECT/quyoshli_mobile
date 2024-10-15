// To parse this JSON data, do
//
//     final partnersModel = partnersModelFromJson(jsonString);

import 'dart:convert';

PartnersModel partnersModelFromJson(String str) => PartnersModel.fromJson(json.decode(str));

String partnersModelToJson(PartnersModel data) => json.encode(data.toJson());

class PartnersModel {
  List<PartnerModel>? data;

  PartnersModel({
    this.data,
  });

  factory PartnersModel.fromJson(Map<String, dynamic> json) => PartnersModel(
    data: json["data"] == null ? [] : List<PartnerModel>.from(json["data"]!.map((x) => PartnerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PartnerModel {
  int? id;
  String? name;
  String? image;
  Status? status;
  bool? isPrice;

  PartnerModel({
    this.id,
    this.name,
    this.image,
    this.status,
    this.isPrice,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) => PartnerModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    isPrice: json["is_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status?.toJson(),
    "is_price": isPrice,
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

