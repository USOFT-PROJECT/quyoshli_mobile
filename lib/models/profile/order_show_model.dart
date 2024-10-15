// To parse this JSON data, do
//
//     final orderShowModel = orderShowModelFromJson(jsonString);

import 'dart:convert';

OrderShowModel orderShowModelFromJson(String str) => OrderShowModel.fromJson(json.decode(str));

String orderShowModelToJson(OrderShowModel data) => json.encode(data.toJson());

class OrderShowModel {
  OrderShow? order;

  OrderShowModel({
    this.order,
  });

  factory OrderShowModel.fromJson(Map<String, dynamic> json) => OrderShowModel(
    order: json["data"] == null ? null : OrderShow.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": order?.toJson(),
  };
}

class OrderShow {
  int? id;
  dynamic payUrl;
  Status? status;
  String? paymentType;
  Status? paymentStatus;
  DateTime? createdAt;
  String? deliveryType;
  String? clientType;
  int? totalAmount;
  List<Product>? products;
  Address? address;
  LegalInformation? legalInformation;
  ClientInformation? clientInformation;
  Branch? branch;
  bool? withInstallation;
  bool? withDidox;
  int? priceProducts;
  int? priceDelivery;
  int? priceMaster;

  OrderShow({
    this.id,
    this.payUrl,
    this.status,
    this.paymentType,
    this.paymentStatus,
    this.createdAt,
    this.deliveryType,
    this.clientType,
    this.totalAmount,
    this.products,
    this.address,
    this.legalInformation,
    this.clientInformation,
    this.branch,
    this.withInstallation,
    this.withDidox,
    this.priceProducts,
    this.priceDelivery,
    this.priceMaster,
  });

  factory OrderShow.fromJson(Map<String, dynamic> json) => OrderShow(
    id: json["id"],
    payUrl: json["pay_url"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"] == null ? null : Status.fromJson(json["payment_status"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    deliveryType: json["delivery_type"],
    clientType: json["client_type"],
    totalAmount: json["total_amount"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    legalInformation: json["legal_information"] == null ? null : LegalInformation.fromJson(json["legal_information"]),
    clientInformation: json["client_information"] == null ? null : ClientInformation.fromJson(json["client_information"]),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    withInstallation: json["with_installation"],
    withDidox: json["with_didox"],
    priceProducts: json["price_products"],
    priceDelivery: json["price_delivery"],
    priceMaster: json["price_master"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pay_url": payUrl,
    "status": status?.toJson(),
    "payment_type": paymentType,
    "payment_status": paymentStatus?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "delivery_type": deliveryType,
    "client_type": clientType,
    "total_amount": totalAmount,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "address": address?.toJson(),
    "legal_information": legalInformation?.toJson(),
    "client_information": clientInformation?.toJson(),
    "branch": branch?.toJson(),
    "with_installation": withInstallation,
    "with_didox": withDidox,
    "price_products": priceProducts,
    "price_delivery": priceDelivery,
    "price_master": priceMaster,
  };
}

class Address {
  int? id;
  City? city;
  dynamic home;
  dynamic landmark;

  Address({
    this.id,
    this.city,
    this.home,
    this.landmark,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    home: json["home"],
    landmark: json["landmark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city?.toJson(),
    "home": home,
    "landmark": landmark,
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

class Branch {
  int? id;
  String? name;
  String? address;
  String? phone;
  MapClass? map;

  Branch({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.map,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    map: json["map"] == null ? null : MapClass.fromJson(json["map"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phone,
    "map": map?.toJson(),
  };
}

class MapClass {
  String? lat;
  String? long;

  MapClass({
    this.lat,
    this.long,
  });

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
  };
}

class ClientInformation {
  String? fullName;
  int? phone;

  ClientInformation({
    this.fullName,
    this.phone,
  });

  factory ClientInformation.fromJson(Map<String, dynamic> json) => ClientInformation(
    fullName: json["full_name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "phone": phone,
  };
}

class LegalInformation {
  int? id;
  int? userId;
  String? companyName;
  String? inn;
  String? bankName;
  String? mfo;
  String? oked;
  String? paymentAccount;
  String? address;
  String? email;
  String? phone;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? directorFullName;

  LegalInformation({
    this.id,
    this.userId,
    this.companyName,
    this.inn,
    this.bankName,
    this.mfo,
    this.oked,
    this.paymentAccount,
    this.address,
    this.email,
    this.phone,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.directorFullName,
  });

  factory LegalInformation.fromJson(Map<String, dynamic> json) => LegalInformation(
    id: json["id"],
    userId: json["user_id"],
    companyName: json["company_name"],
    inn: json["inn"],
    bankName: json["bank_name"],
    mfo: json["mfo"],
    oked: json["oked"],
    paymentAccount: json["payment_account"],
    address: json["address"],
    email: json["email"],
    phone: json["phone"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    directorFullName: json["director_full_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "company_name": companyName,
    "inn": inn,
    "bank_name": bankName,
    "mfo": mfo,
    "oked": oked,
    "payment_account": paymentAccount,
    "address": address,
    "email": email,
    "phone": phone,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "director_full_name": directorFullName,
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

class Product {
  int? id;
  String? name;
  int? count;
  int? price;
  int? totalPrice;

  Product({
    this.id,
    this.name,
    this.count,
    this.price,
    this.totalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    count: json["count"],
    price: json["price"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "count": count,
    "price": price,
    "total_price": totalPrice,
  };
}
