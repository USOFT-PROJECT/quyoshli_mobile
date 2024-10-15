import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/product_details_page.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';

import '../../models/main/favourite_products_model.dart';

class FavouriteController extends GetxController {
  List<FavouriteProductModel> products = [];
  bool isLoading = true;


  getProducts() async {
    var response = await Network.GET(Network.FAVOURITE, {});
    var result = favouriteProductsModelFromJson(response!);
    products = result.data ?? [];
    isLoading = false;

    LogService.i(products.length.toString());
    update();
  }

  Future<bool> remove(FavouriteProductModel product) async {
    try {
      await Network.DEL("/api/products/${product.id}/favorites/");
      products.removeWhere((e) => e.id == product.id);
      update();
      return true;
    } catch (e) {
      LogService.e(e.toString());
    }
    return false;
  }

  void goToDetailsProduct(FavouriteProductModel product) async {
    try {
      var response = await Network.GET(
        Network.API_PRODUCT_SHOW
            .replaceFirst(':product_id', product.id.toString()),
        {},
      );
      if (response != null) {
        await Get.to(
            () => ProductDetailsPage(product: Network.parseProduct(response)));
      }
      LogService.d(response.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
    getProducts();
  }
}
