// To parse this JSON data, do
//
//     final partnerDetailModel = partnerDetailModelFromJson(jsonString);

import 'dart:convert';

PartnerDetailModel partnerDetailModelFromJson(String str) => PartnerDetailModel.fromJson(json.decode(str));

String partnerDetailModelToJson(PartnerDetailModel data) => json.encode(data.toJson());

class PartnerDetailModel {
  Data? data;

  PartnerDetailModel({
    this.data,
  });

  factory PartnerDetailModel.fromJson(Map<String, dynamic> json) => PartnerDetailModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? image;
  Status? status;
  String? description;
  String? videoUrl;
  bool? isPrice;

  Data({
    this.id,
    this.name,
    this.image,
    this.status,
    this.description,
    this.videoUrl,
    this.isPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    description: json["description"],
    videoUrl: json["video_url"],
    isPrice: json["is_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status?.toJson(),
    "description": description,
    "video_url": videoUrl,
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
