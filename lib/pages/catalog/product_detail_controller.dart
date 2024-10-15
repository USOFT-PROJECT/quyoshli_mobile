import 'package:get/get.dart';
import 'package:quyoshli/pages/login/login_page.dart';
import 'package:quyoshli/pages/subpage/main_controller.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';

import '../../models/catalog/product_show_model.dart';
import '../../services/utils_service.dart';

class ProductDetailController extends GetxController {
  ShowProduct? product;
  int selectedImage = 0;

  int count = 0;

  void updateCount(int inCart) {
    count = inCart;
    update();
  }

  void changePhoto(int index) {
    selectedImage = index;
    update();
  }

  addCart() async {
    Utils.vibrate();
    bool isRegistered = DBService.getRegistered();
    if (!isRegistered) {
      Get.to(() => LoginPage());
    }

    if (product?.id == null) return;
    try {
      var param = {"product_id": product!.id};
      var response = await Network.POST(Network.API_ADD_CART, param);
      LogService.i(response!);
      count++;
    } on Exception catch (e) {}
    update();
  }

  Future<void> storeFavourite() async {
    bool isRegistered = DBService.getRegistered();
    if (!isRegistered) {
      Get.to(() => const LoginPage());
    }
    try {
      product?.isFavorite == true
          ? await Network.DEL("/api/products/${product?.id}/favorites")
          : await Network.GET("/api/products/${product?.id}/favorites", {});
      product?.isFavorite = !(product?.isFavorite ?? false);
      update();
      Get.find<MainController>().updateFavouriteFromDetails(
          product?.id, product?.isFavorite ?? false);
    } catch (e) {
      LogService.e(e.toString());
    }
  }
}
