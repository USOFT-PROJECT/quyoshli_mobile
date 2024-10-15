import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../services/db_service.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../services/utils_service.dart';
import '../home/home_page.dart';

class MyInfoController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? firstName;
  String? lastName;
  String? middleName;
  String? phoneNumber;

  apiLoadUser() async {
    var response = await Network.GET(Network.API_GET_USER, Network.paramsEmpty());
    var result = Network.parseUser(response!);
    var user = result!;

    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    middleNameController.text = user.middleName ?? "";
    phoneNumberController.text = Utils.formatPhoneNumber(user.phone!);
    update();
  }

  apiUpdateUser() async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String middleName = middleNameController.text.toString();

    await Network.PUT(
      Network.API_GET_USER,
      body: Network.updateUserParams(firstName, lastName, middleName),
    );
    Get.back(result: true);
  }

  dialogDeleteUser(BuildContext context) async {
    var result = await Utils.dialogCommon(
      context,
      "delete_acc".tr,
      "confirm_del".tr,
      false,
    );
    if (result) {
      try {
        await Network.DEL(Network.API_DELETE_ACC);
        DBService.logout();
        DBService.delAccessToken();
        Get.offAll(const HomePage(initialPage: 0));
      } catch (e) {
        LogService.e(e.toString());
      }
    }
  }
}
