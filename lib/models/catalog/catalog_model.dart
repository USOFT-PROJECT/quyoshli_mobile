// To parse this JSON data, do
//
//     final catalogListModel = catalogListModelFromJson(jsonString);

import 'dart:convert';

CatalogListModel catalogListModelFromJson(String str) => CatalogListModel.fromJson(json.decode(str));

String catalogListModelToJson(CatalogListModel data) => json.encode(data.toJson());

class CatalogListModel {
  List<Catalog>? catalog;

  CatalogListModel({
    this.catalog,
  });

  factory CatalogListModel.fromJson(Map<String, dynamic> json) => CatalogListModel(
    catalog: json["data"] == null ? [] : List<Catalog>.from(json["data"]!.map((x) => Catalog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": catalog == null ? [] : List<dynamic>.from(catalog!.map((x) => x.toJson())),
  };
}

class Catalog {
  int? id;
  String? name;
  String? image;
  int? parentId;
  List<Catalog>? parents;

  Catalog({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.parents,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    parentId: json["parent_id"],
    parents: json["parents"] == null ? [] : List<Catalog>.from(json["parents"]!.map((x) => Catalog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "parent_id": parentId,
    "parents": parents == null ? [] : List<dynamic>.from(parents!.map((x) => x.toJson())),
  };
}
