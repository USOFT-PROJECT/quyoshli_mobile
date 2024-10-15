import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/locals/ru_ru.dart';
import '../core/locals/uz_uz.dart';
import 'db_service.dart';

class LangService extends Translations {
  // Default locale
  static final locale = defLanguage(DBService.getLanguage());

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('uz', 'UZ');

  static final langs = [
    'uz',
    'ru',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('uz', 'UZ'),
    const Locale('ru', 'RU'),
  ];

  static final flags = [
    "assets/images/im_flag_england.png",
    "assets/images/im_flag_uzb.png",
    "assets/images/im_flag_russia.png",
  ];

  static Locale defLanguage(String code) {
    var index = langs.indexOf(code);
    return locales[index];
  }

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'uz_UZ': uzUZ, // lang/uz_uz.dart
        'ru_RU': ruRU, // lang/ru_ru.dart
      };

  // Gets locale from language, and updates the locale
  static void changeLocale(String lang) async {
    final locale = _getLocaleFromLanguage(lang);
    if (locale != null) {
      Get.updateLocale(locale);
      DBService.to.setLanguage(lang);
    }
  }

  // Finds language in `langs` list and returns it as Locale
  static Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.deviceLocale;
  }

  // String defaultLanguage() {
  //   final locale = Get.locale;
  //   var lan = locale.toString();
  //   if (lan == "ru_RU") return langs[2];
  //   if (lan == "uz_UZ") return langs[1];
  //   return langs[0];
  // }
}
