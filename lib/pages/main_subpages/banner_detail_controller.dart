import 'package:get/get.dart';
import 'package:quyoshli/models/main/banner_detail_model.dart';
import 'package:quyoshli/services/http_service.dart';

class BannerDetailController extends GetxController {
  BannerDetailModel? bannerDetail;

  getDetails(int id) async {
    var detail = await Network.GET("${Network.API_SLIDER_LIST}/$id", {});
    if (detail != null) {
      var result = bannerDetailModelFromJson(detail);
      bannerDetail = result;
      update();
    }
  }
}
