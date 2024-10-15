import 'package:get/get.dart';
import 'package:quyoshli/pages/main_subpages/usefuls_sub_page.dart';
import 'package:quyoshli/services/http_service.dart';

import '../../models/main/useful_model.dart';

class UsefulController extends GetxController {
  List<UsefulModel> items = [];

  getData() async {
    var response = await Network.GET(Network.API_USEFUL, {});
    var result = usefulModelFromJson(response!);
    items = result.data!;
    update();
  }

  downloadDocument() {}

  gotoUsefulSubpage(item) {
    Get.to(() => UsefulsSubPage(item: item));
  }
}
