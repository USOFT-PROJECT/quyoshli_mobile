import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:vibration/vibration.dart';

class Utils {
  // static String putSpace(String price) {
  //   StringBuffer result = StringBuffer();
  //   int counter = 0;
  //
  //   for (int i = price.length - 1; i >= 0; i--) {
  //     result.write(price[i]);
  //     counter++;
  //
  //     if (counter % 3 == 0 && i != 0) {
  //       result.write(' ');
  //     }
  //   }
  //
  //   return result.toString().split('').reversed.join(); // Reverse the result
  // }

  static String? extractVideoId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?://)?(?:www\.)?(?:youtube\.com/watch\?v=|youtu\.be/)([^&]+)',
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  static void vibrate() async {
    if (Platform.isAndroid) {
      Vibration.vibrate(duration: 100);
    } else if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
    }
  }

  static String putSpace(String price) {
    return price.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (Match match) => '${match[1]} ');
  }

  static String formatPhoneNumberWithMask(String phoneNumber) {
    // Check if the phone number is valid (12 digits including the country code)
    if (phoneNumber.length != 12) {
      throw FormatException("Invalid phone number length");
    }

    // Extract the relevant parts of the phone number
    String countryCode = phoneNumber.substring(0, 3); // +998
    String operatorCode = phoneNumber.substring(3, 5); // 91, 94, etc.
    String firstPart = phoneNumber.substring(5, 8); // *** (masked part)
    String secondPart = phoneNumber.substring(8, 10); // **
    String lastPart = phoneNumber.substring(10, 12); // 77, 01, etc.

    // Return the formatted phone number
    return '+$countryCode $operatorCode *** ** $lastPart';
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 12) {
      throw Exception('Invalid phone number length');
    }

    // Extract parts of the phone number
    String countryCode = phoneNumber.substring(0, 3); // "998"
    String operatorCode = phoneNumber.substring(3, 5); // "91" or "93", etc.
    String firstPart = phoneNumber.substring(5, 8); // "788"
    String secondPart = phoneNumber.substring(8, 10); // "64"
    String thirdPart = phoneNumber.substring(10, 12); // "77"

    // Format the number
    return '+$countryCode $operatorCode $firstPart $secondPart $thirdPart';
  }

  static bool isValidEmail(String email) {
    // Regular expression pattern for validating email addresses.
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  static var phoneNumberMask = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static bool productHasDiscount(num? discount) => (discount ?? 0) > 0;

  static String productCurrentPrice({int? price, int? priceDiscount}) =>
      '${((price ?? 0) - (priceDiscount ?? 0)).decimal} ${'currency'.tr}';

  static int productDiscountPercent({int? price, int? priceDiscount}) =>
      (100 - ((priceDiscount ?? 0) * 100 ~/ (price ?? 1))).abs();

  static Future<bool> dialogCommon(
    BuildContext context,
    String title,
    String message,
    bool isSingle,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textScaler: TextScaler.linear(1),
          ),
          content: Text(message),
          actions: [
            !isSingle
                ? MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "cancel".tr,
                      textScaler: TextScaler.linear(1),
                    ),
                  )
                : const SizedBox.shrink(),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "confirm".tr,
                textScaler: TextScaler.linear(1),
              ),
            ),
          ],
        );
      },
    );
  }

  static commonToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
