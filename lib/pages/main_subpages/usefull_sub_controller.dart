import 'package:get/get.dart';
import 'package:quyoshli/pages/main_subpages/useful_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/main/useful_details_model.dart';
import '../../services/http_service.dart';

class UsefullSubController extends GetxController {
  List<UsefulDetailModel> items = [];

  bool isDocument = false;

  getData(id) async {
    var response = await Network.GET("${Network.API_USEFUL}/$id", {});
    var result = usefulDetailModelFromJson(response!);
    items = result.data!;
    if (items.first.linkUrl != null) {
      isDocument = true;
    }
    update();
  }

  openDocument(String url) {
    launchUrl(Uri.parse(url));
  }

  gotoUsefulSubpage(details) {
    Get.to(() => UsefulDetailPage(
          details: details,
        ));
  }
}
