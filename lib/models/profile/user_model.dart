// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  User? user;

  UserModel({this.user});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": user?.toJson()};
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? language;
  String? phone;
  bool? gender;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.language,
    this.phone,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        language: json["language"],
        phone: json["phone"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "language": language,
        "phone": phone,
        "gender": gender,
      };
}
