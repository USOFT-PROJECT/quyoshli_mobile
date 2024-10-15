// To parse this JSON data, do
//
//     final paymentErrorResponseModel = paymentErrorResponseModelFromJson(jsonString);

import 'dart:convert';

PaymentErrorResponseModel paymentErrorResponseModelFromJson(String str) => PaymentErrorResponseModel.fromJson(json.decode(str));

String paymentErrorResponseModelToJson(PaymentErrorResponseModel data) => json.encode(data.toJson());

class PaymentErrorResponseModel {
  String? message;
  Errors? errors;

  PaymentErrorResponseModel({
    this.message,
    this.errors,
  });

  factory PaymentErrorResponseModel.fromJson(Map<String, dynamic> json) => PaymentErrorResponseModel(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? clientInformation;
  List<String>? clientInformationFullName;

  Errors({
    this.clientInformation,
    this.clientInformationFullName,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    clientInformation: json["client_information"] == null ? [] : List<String>.from(json["client_information"]!.map((x) => x)),
    clientInformationFullName: json["client_information.full_name"] == null ? [] : List<String>.from(json["client_information.full_name"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "client_information": clientInformation == null ? [] : List<dynamic>.from(clientInformation!.map((x) => x)),
    "client_information.full_name": clientInformationFullName == null ? [] : List<dynamic>.from(clientInformationFullName!.map((x) => x)),
  };
}
