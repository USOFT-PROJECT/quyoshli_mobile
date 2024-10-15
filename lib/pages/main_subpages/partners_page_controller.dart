import 'package:get/get.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/login/login_page.dart';
import 'package:quyoshli/pages/main_subpages/partner_detail_page.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/http_service.dart';

import '../../models/main/partners_model.dart';

class PartnersPageController extends GetxController {
  List<PartnerModel> partners = [];

  getPartners() async {
    var response = await Network.GET(Network.PARTNERS, {});
    var result = partnersModelFromJson(response!);
    partners = result.data!;
    update();
  }

  gotoPartnerDetail(PartnerModel partner) {
    var result = DBService.getRegistered();
    if (result) {
      Get.to(() => PartnerDetailPage(partner: partner));
    } else {
      Get.to(() => const LoginPage());
    }
  }
}
