import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/power_model.dart';
import 'package:quyoshli/models/main/region_model.dart';
import 'package:quyoshli/models/main/service_response_model.dart';
import 'package:quyoshli/pages/main_subpages/success_page.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:quyoshli/services/utils_service.dart';

import '../../models/main/services_model.dart';
import '../../models/profile/user_model.dart';

class ServiceDetailController extends GetxController {
  int? powerIndex;

  int? problemIndex;

  int? cityIndex;

  int? regionIndex;

  TextEditingController commentText = TextEditingController();
  TextEditingController nameTextField = TextEditingController();
  TextEditingController phoneField = TextEditingController();

  User? user;

  apiLoadUser() async {
    var response =
        await Network.GET(Network.API_GET_USER, Network.paramsEmpty());
    var result = Network.parseUser(response!);
    user = result!;
    phoneField = TextEditingController(
        text: Utils.formatPhoneNumber(user?.phone ?? "").toString());
    LogService.i(phoneField.text.length.toString());
    if (user!.firstName!.isNotEmpty && user!.lastName!.isNotEmpty ||
        user!.middleName!.isNotEmpty) {
      nameTextField = TextEditingController(
          text:
              "${user?.firstName ?? ''} ${user?.lastName ?? ''} ${user?.middleName ?? ''}");
    }
    update();
  }

  late ServiceModel service;
  List<PowerModel> powers = [];
  List<RegionModel> regions = [];
  List<Problem> problems = [];
  List<City> cities = [];

  init(ServiceModel service) {
    this.service = service;
  }

  onChange(String value) {
    update();
  }

  final String countryCode = '+998';

  onPhonechange(String value) {
    if (phoneField.text.isEmpty) {
      phoneField.text = countryCode;
      phoneField.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneField.text.length));
    } else if (!phoneField.text.startsWith(countryCode)) {
      phoneField.text =
          countryCode + phoneField.text.replaceAll(countryCode, '');
      phoneField.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneField.text.length));
    }
  }

  getData() async {
    var response = await Network.GET(Network.POWERS, {});
    var regionresponse = await Network.GET(Network.REGIONS, {});

    var powerresult = powerModelFromJson(response!);
    powers = powerresult.data ?? [];

    var regionresult = regionModelFromJson(regionresponse!);
    regions = regionresult.data ?? [];

    LogService.i("Problem count: ${service.problems!.length}");
    if (service.problems!.isNotEmpty) {
      problems = service.problems!;
      update();
    }

    if (regions.isNotEmpty && regionIndex != null) {
      cities = regions[regionIndex!].cities!;
    }

    update();
  }

  onPowerChange(int index) {
    powerIndex = index;

    update();
  }

  onProblemChange(int index) {
    problemIndex = index;
    update();
  }

  onRegionChange(int index) {
    regionIndex = index;
    cityIndex = null;
    cities = regions[regionIndex!].cities!;
    update();
  }

  onCityChange(int index) {
    cityIndex = index;
    update();
  }

  appLy() async {
    String comment = commentText.text;
    String phone = phoneField.text.replaceAll(' ', '');
    String name = nameTextField.text;

    var params = {
      'service_id': service.id.toString(),
      if (service.isPower!) 'power_id': powers[powerIndex!].id.toString(),
      if (service.withProblem!)
        'problem_id': problems[problemIndex!].id.toString(),
      'city_id': cities[cityIndex!].id.toString(),
      'comment': comment.toString(),
      'phone': phone.toString(),
      'full_name': name.toString()
    };

    var response = await Network.POST(Network.SERVICES, params);

    if (response != null) {
      var result = serviceResponseModelFromJson(response);
      Get.to(() => SuccessPage(
            id: result.data?.id ?? 0,
          ));
    }
  }
}
