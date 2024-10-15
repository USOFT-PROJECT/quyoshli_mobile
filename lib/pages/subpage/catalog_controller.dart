import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/products_page.dart';

import '../../models/catalog/catalog_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class CatalogController extends GetxController {
  bool isExpanded = false;
  List<Catalog> catalogs = [];

  getCatalogs() async {
    try {
      var response = await Network.GET(Network.API_CATALOG_LIST, {});

      catalogs = catalogListModelFromJson(response!).catalog!;
      update();

      LogService.i(catalogs.length.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  goToProductPage({String? title, int? id, required int categoryId}) {
    Get.to(
      ProductsPage(
        title: title,
        id: id,
        categoryId: categoryId,
      ),
    );
  }
}
