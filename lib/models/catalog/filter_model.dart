// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  Data data;

  FilterModel({
    required this.data,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  List<SortBy> sortBy;
  List<Brand> brands;

  Data({
    required this.sortBy,
    required this.brands,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sortBy: List<SortBy>.from(json["sort_by"].map((x) => SortBy.fromJson(x))),
    brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sort_by": List<dynamic>.from(sortBy.map((x) => x.toJson())),
    "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
  };
}

class Brand {
  int id;
  String name;
  String image;
  String slug;

  Brand({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
  };
}

class SortBy {
  String name;
  String slug;

  SortBy({
    required this.name,
    required this.slug,
  });

  factory SortBy.fromJson(Map<String, dynamic> json) => SortBy(
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
  };
}
