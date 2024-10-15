// To parse this JSON data, do
//
//     final brancheDataModel = brancheDataModelFromJson(jsonString);

import 'dart:convert';

BranchDataModel branchDataModelFromJson(String str) => BranchDataModel.fromJson(json.decode(str));

String branchDataModelToJson(BranchDataModel data) => json.encode(data.toJson());

class BranchDataModel {
  List<BranchModel>? data;

  BranchDataModel({
    this.data,
  });

  factory BranchDataModel.fromJson(Map<String, dynamic> json) => BranchDataModel(
    data: json["data"] == null ? [] : List<BranchModel>.from(json["data"]!.map((x) => BranchModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BranchModel {
  int? id;
  String? name;
  String? address;
  String? phone;
  MapClass? map;

  BranchModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.map,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    map: json["map"] == null ? null : MapClass.fromJson(json["map"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phone,
    "map": map?.toJson(),
  };
}

class MapClass {
  String? lat;
  String? long;

  MapClass({
    this.lat,
    this.long,
  });

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
  };
}
