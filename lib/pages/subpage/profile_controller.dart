import 'package:get/get.dart';
import 'package:quyoshli/models/profile/feedback_model.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/language/language_page.dart';
import 'package:quyoshli/pages/login/login_page.dart';
import 'package:quyoshli/pages/profile/about_page.dart';
import 'package:quyoshli/pages/profile/my_info_page.dart';
import 'package:quyoshli/pages/terms/terms_page.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/lang_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/profile/about_model.dart';
import '../../models/profile/user_model.dart';
import '../../services/log_service.dart';
import '../../services/utils_service.dart';
import '../profile/my_orders_page.dart';
import '../profile/my_requests_page.dart';

class ProfileController extends GetxController {
  bool isLoading = true;
  late bool isUzbekSelected;
  bool isRegistered = false;

  User? user;
  String? userName = "";
  late FeedbackRes feedback;
  late AboutApp info;

  apiLoadUser() async {
    isRegistered = DBService.getRegistered();
    isUzbekSelected = DBService.getLanguage() == 'ru' ? false : true;
    if (isRegistered) {
      try {
        var response = await Network.GET(Network.API_GET_USER, {});
        user = Network.parseUser(response!);
        LogService.i(user!.toJson().toString());
        userName =
            user!.firstName ?? Utils.formatPhoneNumber(user!.phone.toString());
      } catch (e) {
        LogService.i(e.toString());
        LogService.e(e.toString());
      }
    }

    getFeedback();
  }

  getFeedback() async {
    try {
      var response = await Network.GET(Network.API_FEEDBACK, {});

      feedback = feedbackModelFromJson(response!).data!;
      update();
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  Future<void> launchUrls(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  changeLanguage(bool isUzbek, String lang) {
    isUzbekSelected = isUzbek;
    update();
    LangService.changeLocale(lang);
    Get.back();
  }

  logout() async {
    var response = await Network.POST(Network.API_LOGOUT, {});
    DBService.logout();
    DBService.delAccessToken();
    Get.offAll(const HomePage(initialPage: 0));
  }

  apiChangeLang() async {
    await Network.PUT(
      Network.API_CHANGE_LANG,
      body: Network.changeLangParams('uz'),
    );
  }

  goAboutPage() async {
    try {
      var response = await Network.GET(Network.API_ABOUT_APP, {});

      info = aboutAppFromJson(response!);
      update();
    } catch (e) {
      LogService.e(e.toString());
    }

    Get.to(AboutPage(info: info));
  }

  goMyInfoPage() async {
    var result = await Get.to(const MyInfoPage());
    if (result != null) {
      apiLoadUser();
    }
  }

  goTermsPage() {
    Get.to(TermsPage());
  }

  goMyOrdersPage() {
    Get.to(MyOrdersPage());
  }

  goMyWorksPage() {
    Get.to(MyRequestsPage());
  }

  goLanguagePage() {
    Get.to(LanguagePage());
  }

  goLoginPage() {
    Get.to(const LoginPage(
      isLoginFromHome: true,
    ));
  }
}
