// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  Pagination? pagination;
  List<Request>? data;

  RequestModel({
    this.pagination,
    this.data,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<Request>.from(json["data"]!.map((x) => Request.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Request {
  int? id;
  Status? status;
  DateTime? createdAt;

  Request({
    this.id,
    this.status,
    this.createdAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["id"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status?.toJson(),
    "created_at": createdAt?.toIso8601String(),
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

class Pagination {
  int? current;
  dynamic previous;
  dynamic next;
  int? total;
  int? perPage;
  int? totalItems;

  Pagination({
    this.current,
    this.previous,
    this.next,
    this.total,
    this.perPage,
    this.totalItems,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    current: json["current"],
    previous: json["previous"],
    next: json["next"],
    total: json["total"],
    perPage: json["perPage"],
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "previous": previous,
    "next": next,
    "total": total,
    "perPage": perPage,
    "totalItems": totalItems,
  };
}
