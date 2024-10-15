// To parse this JSON data, do
//
//     final requestShowModel = requestShowModelFromJson(jsonString);

import 'dart:convert';

RequestShowModel requestShowModelFromJson(String str) => RequestShowModel.fromJson(json.decode(str));

String requestShowModelToJson(RequestShowModel data) => json.encode(data.toJson());

class RequestShowModel {
  RequestShow? request;

  RequestShowModel({
    this.request,
  });

  factory RequestShowModel.fromJson(Map<String, dynamic> json) => RequestShowModel(
    request: json["data"] == null ? null : RequestShow.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": request?.toJson(),
  };
}

class RequestShow {
  int? id;
  Service? service;
  Power? power;
  City? city;
  String? comment;
  int? phone;
  String? fullName;
  Status? status;
  Problem? problem;

  RequestShow({
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

  factory RequestShow.fromJson(Map<String, dynamic> json) => RequestShow(
    id: json["id"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    power: json["power"] == null ? null : Power.fromJson(json["power"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    comment: json["comment"],
    phone: json["phone"],
    fullName: json["full_name"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    problem: json["problem"] == null ? null : Problem.fromJson(json["problem"]),
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
    "problem": problem?.toJson(),
  };
}

class City {
  int? id;
  String? name;
  Region? region;

  City({
    this.id,
    this.name,
    this.region,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
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

class Service {
  int? id;
  String? name;
  String? image;
  String? type;
  Status? status;
  bool? isPower;
  bool? withProblem;
  DateTime? createdAt;
  List<Problem>? problems;

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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    problems: json["problems"] == null ? [] : List<Problem>.from(json["problems"]!.map((x) => Problem.fromJson(x))),
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
    "problems": problems == null ? [] : List<dynamic>.from(problems!.map((x) => x.toJson())),
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
