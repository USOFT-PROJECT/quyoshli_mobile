// To parse this JSON data, do
//
//     final aboutApp = aboutAppFromJson(jsonString);

import 'dart:convert';

AboutApp aboutAppFromJson(String str) => AboutApp.fromJson(json.decode(str));

String aboutAppToJson(AboutApp data) => json.encode(data.toJson());

class AboutApp {
  Data data;

  AboutApp({
    required this.data,
  });

  factory AboutApp.fromJson(Map<String, dynamic> json) => AboutApp(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String? name;
  String? body;

  Data({
    required this.id,
    required this.name,
    required this.body,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "body": body,
  };
}
