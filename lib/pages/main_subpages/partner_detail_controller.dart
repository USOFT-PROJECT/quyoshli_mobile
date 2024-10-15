import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/partner_detail_model.dart';
import 'package:quyoshli/pages/main_subpages/success_page.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/main/region_model.dart';
import '../../models/profile/user_model.dart';
import '../../services/utils_service.dart';

class PartnerDetailController extends GetxController {
  PartnerDetailModel partner = PartnerDetailModel();

  TextEditingController commentText = TextEditingController();
  TextEditingController nameTextField = TextEditingController();
  TextEditingController phoneField = TextEditingController(text: '+998');
  TextEditingController priceText = TextEditingController();

  List<RegionModel> regions = [];
  List<City> cities = [];

  int? cityIndex;

  int? regionIndex;

  bool isPrice = false;

  User? user;

  apiLoadUser() async {
    var response =
        await Network.GET(Network.API_GET_USER, Network.paramsEmpty());
    var result = Network.parseUser(response!);
    user = result!;
    phoneField.text = Utils.formatPhoneNumber(user!.phone!);
    if (user!.firstName!.isNotEmpty &&
        user!.lastName!.isNotEmpty ||
        user!.middleName!.isNotEmpty) {
      nameTextField.text =
          "${user!.firstName ?? ''} ${user!.lastName ?? ''} ${user!.middleName ?? ''}";
    }
    update();
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

  getData() async {
    var regionresponse = await Network.GET(Network.REGIONS, {});

    var regionresult = regionModelFromJson(regionresponse!);
    regions = regionresult.data ?? [];

    if (regions.isNotEmpty && regionIndex != null) {
      cities = regions[regionIndex!].cities!;
    }

    update();
  }

  getPartnerDetails(int id) async {
    var response = await Network.GET("${Network.PARTNERS}/$id", {});
    var result = partnerDetailModelFromJson(response!);
    partner = result;
    update();
  }

  appLy() async {
    String comment = commentText.text;
    String phone = phoneField.text.replaceAll(" ", '');
    String name = nameTextField.text;
    String price = priceText.text.isEmpty ? "0" : priceText.text;

    var params = {
      "partner_id": partner.data?.id.toString(),
      if (partner.data?.isPrice ?? false) "price": price,
      "city_id": cities[cityIndex!].id.toString(),
      "comment": comment,
      "phone": phone,
      "full_name": name
    };

    var response = await Network.POST(Network.PARTNERS, params);
    if (response != null) {
      var result = partnerDetailModelFromJson(response);
      Get.to(() => SuccessPage(id: result.data?.id ?? 0));
    }
  }

  openYouTube() async {
    final Uri _url = Uri.parse(partner.data!.videoUrl ?? "");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
