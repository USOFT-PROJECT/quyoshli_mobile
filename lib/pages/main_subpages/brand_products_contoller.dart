import 'package:get/get.dart';
import 'package:quyoshli/models/main/favourite_products_model.dart';
import 'package:quyoshli/services/http_service.dart';

import '../../services/log_service.dart';
import '../catalog/product_details_page.dart';

class BrandProductsController extends GetxController {
  bool isLoading = true;
  List<FavouriteProductModel> products = [];

  getProducts(id) async {
    isLoading = true;
    try {
      var response = await Network.GET("/api/$id/products", {});
      var result = favouriteProductsModelFromJson(response!);
      products = result.data!;
      isLoading = false;
      update();
    } on Exception catch (e) {
      isLoading = false;
      update();
    }
  }

  void goToDetailsProduct(FavouriteProductModel product, index) async {
    try {
      var response = await Network.GET(
        Network.API_PRODUCT_SHOW
            .replaceFirst(':product_id', product.id.toString()),
        {},
      );
      if (response != null) {
        bool? result = await Get.to(
            () => ProductDetailsPage(product: Network.parseProduct(response)));
        products[index].isFavorite = result ??false;
        update();
      }
      LogService.d(response.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
    //getProducts();
  }
}
