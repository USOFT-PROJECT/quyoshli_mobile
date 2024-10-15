// To parse this JSON data, do
//
//     final partnerResponseModel = partnerResponseModelFromJson(jsonString);

import 'dart:convert';

PartnerResponseModel partnerResponseModelFromJson(String str) => PartnerResponseModel.fromJson(json.decode(str));

String partnerResponseModelToJson(PartnerResponseModel data) => json.encode(data.toJson());

class PartnerResponseModel {
  Data? data;

  PartnerResponseModel({
    this.data,
  });

  factory PartnerResponseModel.fromJson(Map<String, dynamic> json) => PartnerResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  Partner? partner;
  City? city;
  String? comment;
  String? phone;
  String? fullName;

  Data({
    this.id,
    this.partner,
    this.city,
    this.comment,
    this.phone,
    this.fullName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    partner: json["partner"] == null ? null : Partner.fromJson(json["partner"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    comment: json["comment"],
    phone: json["phone"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "partner": partner?.toJson(),
    "city": city?.toJson(),
    "comment": comment,
    "phone": phone,
    "full_name": fullName,
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

class Partner {
  int? id;
  String? name;
  String? image;
  String? status;
  bool? isPrice;

  Partner({
    this.id,
    this.name,
    this.image,
    this.status,
    this.isPrice,
  });

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    isPrice: json["is_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status,
    "is_price": isPrice,
  };
}
