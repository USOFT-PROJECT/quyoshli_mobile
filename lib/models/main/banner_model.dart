// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  List<BannerModel>? data;

  SliderModel({
    this.data,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    data: json["data"] == null ? [] : List<BannerModel>.from(json["data"]!.map((x) => BannerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BannerModel {
  int? id;
  String? name;
  String? image;

  BannerModel({
    this.id,
    this.name,
    this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
