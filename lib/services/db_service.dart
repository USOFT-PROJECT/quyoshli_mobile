import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quyoshli/services/log_service.dart';

import 'lang_service.dart';

class DBService {
  static final GetStorage _box = GetStorage();

  static DBService get to => Get.put(DBService());

  static Future<void> init() async {
    await Get.putAsync<DBService>(() async {
      final storageService = DBService();
      await GetStorage.init();
      return storageService;
    }, permanent: true);
  }

  // Access Token
  static Future<void> setAccessToken(String? value) async {
    await _box.write(_StorageKeys.ACCESS_TOKEN, value);
  }

  static String getAccessToken() {
    return _box.read(_StorageKeys.ACCESS_TOKEN) ?? "";
  }

  static Future<void> delAccessToken() async {
    await _box.remove(_StorageKeys.ACCESS_TOKEN);
  }

  //for getting app Language
  static String getLanguage() {
    var lang = _box.read(_StorageKeys.LANGUAGE);
    if (lang == null || lang.isEmpty) return LangService.langs[0];
    LogService.i(lang);
    return lang;
  }

  //for setting app language
  Future<void> setLanguage(String code) async {
    await _box.write(_StorageKeys.LANGUAGE, code);
  }

  // registered
  static Future<void> registerUser() async {
    await _box.write(_StorageKeys.IS_REGISTERED, true);
  }

  static Future<void> logout() async {
    await _box.write(_StorageKeys.IS_REGISTERED, false);
  }

  static bool getRegistered() {
    return _box.read(_StorageKeys.IS_REGISTERED) ?? false;
  }

  //for setting language chosen
  static Future<void> setlanguage() async {
    await _box.write(_StorageKeys.IS_LANGUAGE_SET, true);
  }

  //for showing language page once
  static bool getlanguage() {
    return _box.read(_StorageKeys.IS_LANGUAGE_SET) ?? false;
  }
}

class _StorageKeys {
  static const IS_REGISTERED = 'registered';
  static const ACCESS_TOKEN = 'access_token';
  static const FIREBASE_TOKEN = 'firebase_token';
  static const LANGUAGE = 'language';
  static const IS_LANGUAGE_SET = 'is_language_set';
}
