// To parse this JSON data, do
//
//     final paymentResponseModel = paymentResponseModelFromJson(jsonString);

import 'dart:convert';

PaymentResponseModel paymentResponseModelFromJson(String str) => PaymentResponseModel.fromJson(json.decode(str));

String paymentResponseModelToJson(PaymentResponseModel data) => json.encode(data.toJson());

class PaymentResponseModel {
  PaymentModel? data;

  PaymentResponseModel({
    this.data,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) => PaymentResponseModel(
    data: json["data"] == null ? null : PaymentModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class PaymentModel {
  int? id;
  String? paymentType;
  String? payUrl;
  dynamic contractUrl;

  PaymentModel({
    this.id,
    this.paymentType,
    this.payUrl,
    this.contractUrl,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json["id"],
    paymentType: json["payment_type"],
    payUrl: json["pay_url"],
    contractUrl: json["contract_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_type": paymentType,
    "pay_url": payUrl,
    "contract_url": contractUrl,
  };
}
