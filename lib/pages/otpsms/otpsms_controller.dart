import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quyoshli/models/login/login_response_model.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';

import '../home/home_page.dart';

class OtpSmsController extends GetxController {
  bool isLoading = true;
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController smsEditingController = TextEditingController();
  String otpCode = "";
  int seconds = 60;

  String obscure(String phoneNumber){
    // Split the phone number into individual parts
    List<String> parts = phoneNumber.split(' ');

    // Ensure the phone number has the correct format
    if (parts.length != 5) {
      return phoneNumber; // Return as is if the format is unexpected
    }

    // Replace the middle part (index 2) with '***' and the fourth part with '**'
    parts[2] = '***';
    parts[3] = '**';

    // Join the parts back together
    return parts.join(' ');
    return'';
  }

  void waitForOneMinute() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds > 1) {
        //print(seconds);
        seconds--;
        update();
      } else {
        print("Countdown completed!");
        seconds = 60;
        update();
        timer.cancel(); // Stop the timer
      }
    });
  }

  verify(String phoneNumber, bool isLoginFromHome) async {
    var params = {"phone": phoneNumber, "verify_code": otpCode};
    if (otpCode.length == 5) {
      try {
        var uri = Uri.http(Network.getServer(), Network.API_VERIFY, params);
        var response = await Network.client.post(uri, body: jsonEncode(params));
        if (response.statusCode == 200 || response.statusCode == 201) {
          var result = loginResponseModelFromJson(response.body);
          DBService.setAccessToken(result.data.accessToken);
          DBService.registerUser();
          LogService.i(result.data.accessToken);

          if(isLoginFromHome){
            Get.offAll(()=> HomePage(initialPage: 3));
          }else{
            Get.back();
          }
        } else {
          LogService.e(response.body);
          errorController!.add(ErrorAnimationType.shake);
        }
      } on SocketException catch (_) {
        // if the network connection fails
        rethrow;
      }
    } else {
      errorController!.add(ErrorAnimationType.shake);
    }
  }

  resend(String phone) async {
    if(seconds == 60){
      waitForOneMinute();

      var param = {"phone": phone};
      var response = await Network.POST(Network.API_AUTH, param);
      LogService.i(response ?? "error");
    }else{
      LogService.i("Отправить заново should work only after 1 minute");
    }
  }
}
