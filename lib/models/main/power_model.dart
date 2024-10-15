// To parse this JSON data, do
//
//     final powerModel = powerModelFromJson(jsonString);

import 'dart:convert';

PowersModel powerModelFromJson(String str) => PowersModel.fromJson(json.decode(str));

String powerModelToJson(PowersModel data) => json.encode(data.toJson());

class PowersModel {
  List<PowerModel>? data;

  PowersModel({
    this.data,
  });

  factory PowersModel.fromJson(Map<String, dynamic> json) => PowersModel(
    data: json["data"] == null ? [] : List<PowerModel>.from(json["data"]!.map((x) => PowerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PowerModel {
  int? id;
  String? name;
  int? power;

  PowerModel({
    this.id,
    this.name,
    this.power,
  });

  factory PowerModel.fromJson(Map<String, dynamic> json) => PowerModel(
    id: json["id"],
    name: json["name"],
    power: json["power"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "power": power,
  };
}
