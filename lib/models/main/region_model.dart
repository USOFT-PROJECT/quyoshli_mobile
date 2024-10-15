// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionsModel regionModelFromJson(String str) => RegionsModel.fromJson(json.decode(str));

String regionModelToJson(RegionsModel data) => json.encode(data.toJson());

class RegionsModel {
  List<RegionModel>? data;

  RegionsModel({
    this.data,
  });

  factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
    data: json["data"] == null ? [] : List<RegionModel>.from(json["data"]!.map((x) => RegionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RegionModel {
  int? id;
  String? name;
  List<City>? cities;

  RegionModel({
    this.id,
    this.name,
    this.cities,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    id: json["id"],
    name: json["name"],
    cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
  };
}

class City {
  int? id;
  String? name;

  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
