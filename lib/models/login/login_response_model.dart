// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  Data data;

  LoginResponseModel({
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String phone;
  String accessToken;

  Data({
    required this.id,
    required this.phone,
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        phone: json["phone"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "access_token": accessToken,
      };
}
