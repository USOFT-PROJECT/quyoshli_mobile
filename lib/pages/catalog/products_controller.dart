import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/filter_page.dart';
import 'package:quyoshli/pages/main_subpages/search_page.dart';

import '../../models/catalog/filter_model.dart';
import '../../models/catalog/product_model.dart';
import '../../models/catalog/product_show_model.dart';
import '../../models/main/products_model.dart';
import '../../services/db_service.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../login/login_page.dart';
import 'product_details_page.dart';

class ProductsController extends GetxController {
  late CartProductModel productModel;
  late ShowProduct showProduct;
  List<Product> products = [];
  bool isLoading = true;
  bool sortOptionSelected = false;
  bool brandOptionSelected = false;
  bool priceOptionSelected = false;

  late ScrollController scrollController = ScrollController();

  late String title;
  late int id;
  late int categoryId;

  late FilterModel filterModel;

  int currentPage = 1;

  List<SortBy> sort_by = [];
  SortBy selectedSortOption = SortBy(name: '', slug: '');

  bool isSortingBottomSheetOpen = false; // To manage the arrow direction

  List<Brand> brands = [];
  Brand selectedBrandOption = Brand(id: 0, name: "", image: "", slug: "");

  bool isBrandBottomSheetOpen = false; // To manage the arrow direction
  bool isPriceBottomSheetOpen = false;
  bool firstLoadCompleted = false;

  bool get productsInitiallyAvailable => products.isNotEmpty;

  final TextEditingController priceFromController = TextEditingController();
  final TextEditingController priceToController = TextEditingController();

  bool areFiltersApplied() {
    return selectedSortOption.slug.isEmpty &&
        selectedBrandOption.id == 0 &&
        priceFromController.text.isEmpty &&
        priceToController.text.isEmpty;
  }

  apiProducts(
      String slug, int brandId, String priceFrom, String priceTo) async {
    try {
      isLoading = true;
      var response = await Network.GET(
        Network.API_PRODUCT_LIST.replaceFirst(":category_id", id.toString()),
        Network.paramsProductsList(
          currentPage,
          slug,
          brandId,
          priceFrom,
          priceTo,
        ),
      );
      productModel = productModelFromJson(response!);

      products.addAll(productModel.data!);
      isLoading = false;
      firstLoadCompleted = true;

      update();
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  goToDetailsProduct(Product product, index) async {
    try {
      var response = await Network.GET(
        Network.API_PRODUCT_SHOW
            .replaceFirst(':product_id', product.id.toString()),
        {},
      );

      showProduct = Network.parseProduct(response!)!;
      update();
    } catch (e) {
      LogService.e(e.toString());
    }

    bool result = await Get.to(() => ProductDetailsPage(product: showProduct));
    products[index].isFavorite = result;
    update();
    apiFilters(categoryId);
  }

  apiFilters(int categoryId) async {
    try {
      var response = await Network.GET(
        Network.API_FILTER.replaceFirst(":category_id", categoryId.toString()),
        {},
      );

      filterModel = filterModelFromJson(response!);

      sort_by = filterModel.data.sortBy;
      brands = filterModel.data.brands;
      update();
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  goToSearchPage() {
    Get.to(const SearchPage());
  }

  goToFilterPage() {
    Get.to(const FilterPage());
  }

  Future<bool?> storeFavourite(String productId, bool isSelected) async {
    bool isRegistered = DBService.getRegistered();
    if (!isRegistered) {
      Get.to(() => const LoginPage());
      return null;
    }
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

  // void scrollListener() {
  //   if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
  //     if (currentPage <= productModel.pagination!.total!.toDouble()) {
  //       currentPage++;
  //       apiProducts(
  //         selectedSortOption.slug,
  //         selectedBrandOption.id,
  //         priceFromController.text,
  //         priceToController.text,
  //       );
  //     }
  //   }
  // }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (productModel.pagination?.next != null) {
        currentPage = productModel.pagination?.next;
        apiProducts(
          selectedSortOption.slug,
          selectedBrandOption.id,
          priceFromController.text,
          priceToController.text,
        ).then((response) {
          currentPage = response.pagination['current'];
          productModel.pagination?.next = response.pagination['next'];
          productModel.pagination?.total = response.pagination['total'];
        }).catchError((error) {
          LogService.e(error);
        });
      }
    }
  }

  back() {
    Get.back();
  }

  void clear() {
    products = [];
    sort_by = [];
    brands = [];
  }
}
