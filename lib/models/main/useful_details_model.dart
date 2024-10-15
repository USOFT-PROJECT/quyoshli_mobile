// To parse this JSON data, do
//
//     final usefulModel = usefulModelFromJson(jsonString);

import 'dart:convert';

UsefulDetailsModel usefulDetailModelFromJson(String str) => UsefulDetailsModel.fromJson(json.decode(str));

String usefulModelToJson(UsefulDetailsModel data) => json.encode(data.toJson());

class UsefulDetailsModel {
  List<UsefulDetailModel>? data;

  UsefulDetailsModel({
    this.data,
  });

  factory UsefulDetailsModel.fromJson(Map<String, dynamic> json) => UsefulDetailsModel(
    data: json["data"] == null ? [] : List<UsefulDetailModel>.from(json["data"]!.map((x) => UsefulDetailModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UsefulDetailModel {
  int? id;
  String? name;
  String? description;
  String? videoUrl;
  dynamic linkUrl;
  dynamic fileUrl;

  UsefulDetailModel({
    this.id,
    this.name,
    this.description,
    this.videoUrl,
    this.linkUrl,
    this.fileUrl,
  });

  factory UsefulDetailModel.fromJson(Map<String, dynamic> json) => UsefulDetailModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    videoUrl: json["video_url"],
    linkUrl: json["link_url"],
    fileUrl: json["file_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "video_url": videoUrl,
    "link_url": linkUrl,
    "file_url": fileUrl,
  };
}
