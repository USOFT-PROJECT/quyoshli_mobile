// To parse this JSON data, do
//
//     final policyModel = policyModelFromJson(jsonString);

import 'dart:convert';

PolicyModel policyModelFromJson(String str) => PolicyModel.fromJson(json.decode(str));

String policyModelToJson(PolicyModel data) => json.encode(data.toJson());

class PolicyModel {
  Policy? data;

  PolicyModel({
    this.data,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
    data: json["data"] == null ? null : Policy.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Policy {
  int? id;
  String? name;
  String? body;

  Policy({
    this.id,
    this.name,
    this.body,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
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
