import 'dart:async';

import 'package:get/get.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/language/language_page.dart';
import 'package:quyoshli/services/db_service.dart';

class SplashController extends GetxController {
  bool isLoading = true;

  callNextPage() {
    bool isLanguegeset = DBService.getlanguage();
    if (!isLanguegeset) {
      Get.off(() => const LanguagePage());
    } else {
      Get.off(() => const HomePage(initialPage: 0,));
    }
  }

  initTimer() {
    Timer(const Duration(seconds: 2), () {
      callNextPage();
    });
  }
}
