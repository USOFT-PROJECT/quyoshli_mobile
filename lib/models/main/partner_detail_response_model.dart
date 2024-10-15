// To parse this JSON data, do
//
//     final partnerDetailResponseModel = partnerDetailResponseModelFromJson(jsonString);

import 'dart:convert';

PartnerDetailResponseModel partnerDetailResponseModelFromJson(String str) => PartnerDetailResponseModel.fromJson(json.decode(str));

String partnerDetailResponseModelToJson(PartnerDetailResponseModel data) => json.encode(data.toJson());

class PartnerDetailResponseModel {
  Data? data;

  PartnerDetailResponseModel({
    this.data,
  });

  factory PartnerDetailResponseModel.fromJson(Map<String, dynamic> json) => PartnerDetailResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  PartnerResponseModel? partner;
  PartnerCityModel? city;
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
    partner: json["partner"] == null ? null : PartnerResponseModel.fromJson(json["partner"]),
    city: json["city"] == null ? null : PartnerCityModel.fromJson(json["city"]),
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

class PartnerCityModel {
  int? id;
  String? name;
  PartnerRegionModel? region;

  PartnerCityModel({
    this.id,
    this.name,
    this.region,
  });

  factory PartnerCityModel.fromJson(Map<String, dynamic> json) => PartnerCityModel(
    id: json["id"],
    name: json["name"],
    region: json["region"] == null ? null : PartnerRegionModel.fromJson(json["region"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "region": region?.toJson(),
  };
}

class PartnerRegionModel {
  int? id;
  String? name;

  PartnerRegionModel({
    this.id,
    this.name,
  });

  factory PartnerRegionModel.fromJson(Map<String, dynamic> json) => PartnerRegionModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class PartnerResponseModel {
  int? id;
  String? name;
  String? image;
  String? status;
  bool? isPrice;

  PartnerResponseModel({
    this.id,
    this.name,
    this.image,
    this.status,
    this.isPrice,
  });

  factory PartnerResponseModel.fromJson(Map<String, dynamic> json) => PartnerResponseModel(
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
