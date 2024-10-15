import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/services/db_service.dart';

class LanguageController extends GetxController {
  bool isUzbek = true;

  setLanguage() async {
    await DBService.setlanguage();
  }

  changeLanguage(String lan) {
    if (lan == 'uz') {
      Get.updateLocale(const Locale('uz', 'UZ'));
      DBService.to.setLanguage('uz');
      isUzbek = true;
    } else {
      Get.updateLocale(const Locale('ru', 'RU'));
      DBService.to.setLanguage('ru');
      isUzbek = false;
    }
    update();
  }

  // getCurrentLanguage(BuildContext context) {
  //   Locale locale = context.locale;
  //   if (locale.languageCode == 'uz') {
  //     isUzbek = true;
  //   } else {
  //     isUzbek = false;
  //   }
  // }

  callNextPage() {
    Get.off(const HomePage());
  }

// changeLanguage2(BuildContext context, String locale) async {
//   LogService.i(locale);
//   if (locale == 'ru') {
//     if (isUzbek) {
//       isUzbek = false;
//      context
//           .setLocale(const Locale('ru', 'RU'))
//           .then((_) {
//         update(); // Trigger GetX to rebuild the UI after locale change
//       });
//     }
//   }
//   if (locale == 'uz') {
//     if (!isUzbek) {
//       isUzbek = true;
//     context
//           .setLocale(const Locale('uz', 'UZ'))
//           .then((_) {
//         update(); // Trigger GetX to rebuild the UI after locale change
//       });
//     }
//   }
// }
}
