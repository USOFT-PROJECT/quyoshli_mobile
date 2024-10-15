// To parse this JSON data, do
//
//     final bannerDetailModel = bannerDetailModelFromJson(jsonString);

import 'dart:convert';

BannerDetailModel bannerDetailModelFromJson(String str) => BannerDetailModel.fromJson(json.decode(str));

String bannerDetailModelToJson(BannerDetailModel data) => json.encode(data.toJson());

class BannerDetailModel {
  Data? data;

  BannerDetailModel({
    this.data,
  });

  factory BannerDetailModel.fromJson(Map<String, dynamic> json) => BannerDetailModel(
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
  String? description;
  int? views;
  DateTime? createdAt;

  Data({
    this.id,
    this.name,
    this.image,
    this.description,
    this.views,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    views: json["views"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "views": views,
    "created_at": createdAt?.toIso8601String(),
  };
}
