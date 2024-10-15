// To parse this JSON data, do
//
//     final usefulModel = usefulModelFromJson(jsonString);

import 'dart:convert';

UsefullsModel usefulModelFromJson(String str) => UsefullsModel.fromJson(json.decode(str));

String usefulModelToJson(UsefullsModel data) => json.encode(data.toJson());

class UsefullsModel {
  List<UsefulModel>? data;

  UsefullsModel({
    this.data,
  });

  factory UsefullsModel.fromJson(Map<String, dynamic> json) => UsefullsModel(
    data: json["data"] == null ? [] : List<UsefulModel>.from(json["data"]!.map((x) => UsefulModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UsefulModel {
  int? id;
  String? name;
  String? image;

  UsefulModel({
    this.id,
    this.name,
    this.image,
  });

  factory UsefulModel.fromJson(Map<String, dynamic> json) => UsefulModel(
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
