// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) => FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  FeedbackRes? data;

  FeedbackModel({
    this.data,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    data: json["data"] == null ? null : FeedbackRes.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class FeedbackRes {
  String? phone;
  String? telegramSupport;

  FeedbackRes({
    this.phone,
    this.telegramSupport,
  });

  factory FeedbackRes.fromJson(Map<String, dynamic> json) => FeedbackRes(
    phone: json["phone"],
    telegramSupport: json["telegram_support"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "telegram_support": telegramSupport,
  };
}
