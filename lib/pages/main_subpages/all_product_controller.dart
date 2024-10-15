import 'package:get/get.dart';
import 'package:quyoshli/services/http_service.dart';

import '../../models/catalog/product_model.dart';
import '../../models/main/products_model.dart';

class AllProductController extends GetxController {
  bool isLoading = false;

  List<Product> products = [];

  getProducts(id) async {
    isLoading = true;
    var response = await Network.GET("${Network.API_PRODUCTs_LIST}/$id", {});
    var result = productModelFromJson(response!);
    products = result.data!;
    isLoading = false;
    update();
  }
}
