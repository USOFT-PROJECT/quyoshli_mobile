import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/otpsms/otpsms_page.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';

class LoginController extends GetxController {
  bool isLoading = true;

  final phoneController = TextEditingController(text: '+998 ');

  login(bool isLoginFromHome) async {
    var phone = phoneController.text;
    var param = {"phone": phone};

    Get.off(() => OtpSmsPage(phoneNumber: phone, isLoginFromHome: isLoginFromHome,));
    var response = await Network.POST(Network.API_AUTH, param);
    LogService.i(response ?? "error");
  }
}
