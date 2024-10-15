// To parse this JSON data, do
//
//     final serviceResponseModel = serviceResponseModelFromJson(jsonString);

import 'dart:convert';

ServiceResponseModel serviceResponseModelFromJson(String str) =>
    ServiceResponseModel.fromJson(json.decode(str));

String serviceResponseModelToJson(ServiceResponseModel data) =>
    json.encode(data.toJson());

class ServiceResponseModel {
  Data? data;

  ServiceResponseModel({
    this.data,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) =>
      ServiceResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  Service? service;
  Power? power;
  ServiceCity? city;
  String? comment;
  String? phone;
  String? fullName;
  Status? status;
  dynamic problem;

  Data({
    this.id,
    this.service,
    this.power,
    this.city,
    this.comment,
    this.phone,
    this.fullName,
    this.status,
    this.problem,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        power: json["power"] == null ? null : Power.fromJson(json["power"]),
        city: json["city"] == null ? null : ServiceCity.fromJson(json["city"]),
        comment: json["comment"],
        phone: json["phone"],
        fullName: json["full_name"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        problem: json["problem"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service?.toJson(),
        "power": power?.toJson(),
        "city": city?.toJson(),
        "comment": comment,
        "phone": phone,
        "full_name": fullName,
        "status": status?.toJson(),
        "problem": problem,
      };
}

class ServiceCity {
  int? id;
  String? name;
  Region? region;

  ServiceCity({
    this.id,
    this.name,
    this.region,
  });

  factory ServiceCity.fromJson(Map<String, dynamic> json) => ServiceCity(
        id: json["id"],
        name: json["name"],
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region?.toJson(),
      };
}

class Region {
  int? id;
  String? name;

  Region({
    this.id,
    this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Power {
  int? id;
  String? name;
  int? power;

  Power({
    this.id,
    this.name,
    this.power,
  });

  factory Power.fromJson(Map<String, dynamic> json) => Power(
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

class Service {
  int? id;
  String? name;
  String? image;
  String? type;
  Status? status;
  bool? isPower;
  bool? withProblem;
  DateTime? createdAt;
  List<ServiceProblem>? problems;

  Service({
    this.id,
    this.name,
    this.image,
    this.type,
    this.status,
    this.isPower,
    this.withProblem,
    this.createdAt,
    this.problems,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        isPower: json["is_power"],
        withProblem: json["with_problem"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        problems: json["problems"] == null
            ? []
            : List<ServiceProblem>.from(
                json["problems"]!.map((x) => ServiceProblem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "type": type,
        "status": status?.toJson(),
        "is_power": isPower,
        "with_problem": withProblem,
        "created_at": createdAt?.toIso8601String(),
        "problems": problems == null
            ? []
            : List<dynamic>.from(problems!.map((x) => x.toJson())),
      };
}

class ServiceProblem {
  int? id;
  String? title;

  ServiceProblem({
    this.id,
    this.title,
  });

  factory ServiceProblem.fromJson(Map<String, dynamic> json) => ServiceProblem(
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
