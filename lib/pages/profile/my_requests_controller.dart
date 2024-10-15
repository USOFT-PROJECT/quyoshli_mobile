import 'package:get/get.dart';
import 'package:quyoshli/pages/profile/request_show_page.dart';

import '../../models/profile/request_show_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import 'order_check_page.dart';

class MyRequestsController extends GetxController {
  late RequestShow request;

  goRequestShowPage(String id) async {
    try {
      var response = await Network.GET(
        Network.API_REQUEST_SHOW.replaceFirst(':request_id', id),
        {},
      );

      request = requestShowModelFromJson(response!).request!;
      update();

      LogService.d(response.toString());
    } catch (e) {
      LogService.e(e.toString());
    }

    Get.to(RequestShowPage(request: request));
  }
}
