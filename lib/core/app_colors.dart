import 'package:flutter/material.dart';

class AppColors {
  static const Color mainAppColor = Color(0xFF033739);
  static const Color scaffold = Colors.white;

  //color for ordering page
  static const Color filterChosenColor = Color(0xFFCCEECC);
  static const Color filterBorderColor = Color(0xFFA8ACA8);
  static const Color textFieldLabelColor = Color(0xFF454745);
  static const Color textFieldColor = Color(0xFFF1F1F1);
  static const Color textColor = Color(0xFF111111);
  static const Color secondary = Color(0xFFF1F1F1);

  static const Color buttonColor = Color.fromRGBO(3, 55, 57, 1);

  static Color hexToColor(String hexString) {
    // Remove the "#" symbol if it exists
    hexString = hexString.replaceAll('#', '');

    // If the string is 6 characters long, add the alpha value (FF) at the beginning
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }

    // Parse the hex string and create a Color object
    return Color(int.parse(hexString, radix: 16));
  }

  const AppColors._();
}
