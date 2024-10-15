// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) =>
    ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

class ServicesModel {
  List<ServiceModel>? data;

  ServicesModel({
    this.data,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        data: json["data"] == null
            ? []
            : List<ServiceModel>.from(
                json["data"]!.map((x) => ServiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ServiceModel {
  int? id;
  String? name;
  String? image;
  String? type;
  Status? status;
  bool? isPower;
  bool? withProblem;
  List<Problem>? problems;

  ServiceModel({
    this.id,
    this.name,
    this.image,
    this.type,
    this.status,
    this.isPower,
    this.withProblem,
    this.problems,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        isPower: json["is_power"],
        withProblem: json["with_problem"],
        problems: json["problems"] == null
            ? []
            : List<Problem>.from(
                json["problems"]!.map((x) => Problem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "type": type,
        "status": status?.toJson(),
        "is_power": isPower,
        "with_problem": withProblem,
        "problems": problems == null
            ? []
            : List<dynamic>.from(problems!.map((x) => x.toJson())),
      };
}

class Problem {
  int? id;
  String? title;

  Problem({
    this.id,
    this.title,
  });

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
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
