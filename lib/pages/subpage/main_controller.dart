import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/banner_model.dart';
import 'package:quyoshli/models/main/brand_list_model.dart';
import 'package:quyoshli/models/main/products_model.dart';
import 'package:quyoshli/pages/login/login_page.dart';
import 'package:quyoshli/pages/main_subpages/favourite_page.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';

import '../../models/catalog/product_show_model.dart';
import '../catalog/product_details_page.dart';

class MainController extends GetxController {
  bool isLoading = true;
  late Timer bannerTimer;
  int currentPage = 0;

  List<BannerModel> banners = [];
  List<BrandModel> brands = [];
  List<ProductList> productList = [];

  late PageController pageController;

  setBannerPeriodicTime(){
    // Set up a timer to auto-swap banners
    bannerTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage < banners.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  getBanners() async {
    LogService.i("Start getting banners");
    var result = await Network.GET(Network.API_SLIDER_LIST, {});
    if (result != null) {
      var sliders = sliderModelFromJson(result);
      banners = sliders.data!;
      LogService.i("items :${banners.length}");
      update();
    } else {
      LogService.i("items :${banners.length}");
    }
  }

  getBrands() async {
    var response = await Network.GET(Network.API_BRAND_LIST, {'page': '1', 'limit': '10'});
    var result = brandListModelFromJson(response!);
    brands = result.data!;
  }

  getProducts() async {
    var response = await Network.GET(Network.API_PRODUCTs_LIST, {});
    var result = productListModelFromJson(response!);
    productList = result.data!;
    update();
  }

  getData() async {
    isLoading = true;
    await getBanners();
    await getProducts();
    await getBrands();
    isLoading = false;
    update();
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

  gotoFavourite() async {
    bool isRegistered = DBService.getRegistered();
    if (isRegistered) {
      await Get.to(() => const FavouritePage());
      update();
    } else {
      Get.to(() => const LoginPage());
    }
    getProducts();
  }

  //new design
  callNextPage(String route, context) {
    Navigator.of(context).pushNamed(route);
  }

  //product details
  late ShowProduct showProduct;

  goToDetailsProduct(Product product) async {
    try {
      var response = await Network.GET(
        Network.API_PRODUCT_SHOW
            .replaceFirst(':product_id', product.id.toString()),
        {},
      );

      showProduct = Network.parseProduct(response!)!;
      update();
      //LogService.d(response.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
    await Get.to(() => ProductDetailsPage(product: showProduct));
    getProducts();
  }

  void updateFavouriteFromDetails(int? productId, bool value) {
    for (int i = 0; i < productList.length; i++) {
      for (int j = 0; j < (productList[i].products ?? []).length; j++) {
        if ((productList[i].products ?? [])[j].id == productId) {
          (productList[i].products ?? [])[j].isFavorite = value;
          update();
          return;
        }
      }
    }
  }
}
