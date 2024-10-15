import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/debouncer.dart';
import 'package:quyoshli/pages/catalog/product_details_page.dart';
import 'package:quyoshli/services/log_service.dart';

import '../../models/main/favourite_products_model.dart';
import '../../services/http_service.dart';

class SearchPageController extends GetxController {
  List<FavouriteProductModel> products = [];

  TextEditingController searchController = TextEditingController();

  final _debouncer = Debouncer();

  bool searched = false;
  bool isLoading = false;

  clearTextField() {
    searchController.clear();
    update();
  }

  void search(String query) {
    _debouncer.debounce(
      duration: const Duration(milliseconds: 500),
      onDebounce: () {
        searchAPI(query);
      },
    );
  }

  searchAPI(String query) async {
    isLoading = true;
    searched = true;
    update();
    var response = await Network.GET(Network.SEARCH, {'query': query});
    var result = favouriteProductsModelFromJson(response!);
    products = result.data ?? [];
    LogService.i("result count ${products.length}");
    isLoading = false;
    update();
  }

  Future<bool?> storeFavourite(String productId, bool isSelected) async {
    try {
      isSelected
          ? await Network.DEL("/api/products/$productId/favorites")
          : await Network.GET("/api/products/$productId/favorites", {});
      return !isSelected;
    } catch (e) {
      LogService.e(e.toString());
    }
    return null;
  }

  void goToDetailsProduct(FavouriteProductModel product, index) async {
    try {
      var response = await Network.GET(
        Network.API_PRODUCT_SHOW
            .replaceFirst(':product_id', product.id.toString()),
        {},
      );
      if (response != null) {
        bool result = await Get.to(
            () => ProductDetailsPage(product: Network.parseProduct(response)));
        products[index].isFavorite = result;
        update();
      }
      LogService.d(response.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
  }
}
