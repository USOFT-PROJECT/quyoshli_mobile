import 'package:get/get.dart';
import 'package:quyoshli/models/main/services_model.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/login/login_page.dart';
import 'package:quyoshli/pages/main_subpages/service_detail_page.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/http_service.dart';

class ServicePageController extends GetxController {
  List<ServiceModel> services = [];

  getServices() async {
    var response = await Network.GET(Network.SERVICES, {});

    var result = servicesModelFromJson(response!);
    services = result.data!;
    update();
  }

  callNextPage(ServiceModel service) {
    var isRegistered = DBService.getRegistered();
    if (isRegistered) {
      Get.to(() => ServiceDetailPage(service: service));
    } else {
      Get.to(() => const LoginPage());
    }
  }
}
