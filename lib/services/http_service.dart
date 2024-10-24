import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:quyoshli/config/root_binding.dart';
import 'package:quyoshli/models/catalog/product_show_model.dart';
import 'package:quyoshli/models/profile/user_model.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:quyoshli/services/utils_service.dart';

import 'http_helper.dart';

class Network {
  static bool isTester = false;
  static String SERVER_DEV = "78.47.216.82";
  static String SERVER_PROD = "api.quyoshli.uz";

  static final client = InterceptedClient.build(
    interceptors: [HttpInterceptor()],
    retryPolicy: HttpRetryPolicy(),
  );

  static String getServer() {
    if (isTester) return SERVER_DEV;
    return SERVER_PROD;
  }

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        //log(response.body);
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      Utils.commonToast("no_connection".tr);
      rethrow;
    }
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    try {
      var uri = Uri.https(getServer(), api);
      var response = await client.post(uri, body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      Utils.commonToast("no_connection".tr);
      rethrow;
    }
  }

  static Future<String?> PUT(String api,
      {Map<String, dynamic> body = const {}}) async {
    try {
      var uri = Uri.https(getServer(), api);
      var response = await client.put(uri, body: jsonEncode(body));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      Utils.commonToast("no_connection".tr);
      rethrow;
    }
  }

  static Future<String?> DEL(String api) async {
    try {
      var uri = Uri.https(getServer(), api);
      var response = await client.delete(uri);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body;
      } else {
        LogService.e(response.body);
        _throwException(response);
      }
    } on SocketException catch (_) {
      Utils.commonToast("no_connection".tr);
      rethrow;
    }
  }

  static _throwException(Response response) {
    String reason = response.reasonPhrase!;
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(reason);
      case 401:
        throw InvalidInputException(reason);
      case 403:
        throw UnauthorisedException(reason);
      case 404:
        throw FetchDataException(reason);
      case 500:
      default:
        throw FetchDataException(reason);
    }
  }

  /* Http Apis*/
  static String API_CAT_LIST = "/v1/images";

  //main
  static String API_SLIDER_LIST = "/api/sliders";
  static String API_BRAND_LIST = "/api/brands";
  static String API_PRODUCTs_LIST = "/api/compilations";
  static String SERVICES = "/api/services";
  static String PARTNERS = "/api/partners";
  static String MAKE_FAVURITE = "/api/favorites";
  static String POWERS = "/api/powers";
  static String REGIONS = "/api/regions";
  static String FAVOURITE = "/api/favorites";
  static String SEARCH = "/api/search";
  static String API_USEFUL = "/api/useful-information";

  // catalog
  static String API_CATALOG_LIST = "/api/categories";
  static String API_PRODUCT_LIST = "/api/categories/:category_id/products";
  static String API_PRODUCT_SHOW = "/api/products/:product_id";
  static String API_FILTER = "/api/categories/:category_id/filter";

  // cart
  static String API_CART = "/api/cart";
  static String API_ADD_CART = "/api/cart";
  static String API_CHECKOUT_PREVIEW = "/api/checkout-preview";
  static String API_BRANCHES = "/api/branches";
  static String API_CHECOUT = "/api/checkout";

  static String API_PAYMENT_SYSTEM = "/api/payment-systems/physical";
  static String API_PAYMENT_LEGAL = "/api/payment-systems/legal";

  //login
  static String API_AUTH = "/api/oauth";
  static String API_VERIFY = "/api/oauth/verify";
  static String API_LOGOUT = "/api/oauth/logout";
  static String API_POLICY = "/api/page/policy";

  // profile
  static String API_GET_USER = "/api/user/me";
  static String API_DELETE_ACC = "/api/user/me";
  static String API_ABOUT_APP = "/api/page/about";
  static String API_FEEDBACK = "/api/feedback";
  static String API_ORDERS_LIST = "/api/user/orders";
  static String API_ORDER_SHOW = "/api/user/orders/:order_id";
  static String API_REQUESTS_LIST = "/api/user/requests";
  static String API_REQUEST_SHOW = "/api/user/requests/:request_id";
  static String API_CHANGE_LANG = "/api/user/language";

  /* Http Params */

  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> params = {};
    return params;
  }

  static Map<String, String> paramsProductsList(
    int currentPage,
    String slug,
    int brandId,
    String priceFrom,
    String priceTo,
  ) {
    Map<String, String> params = {};
    params.addAll({
      'page': currentPage.toString(),
      if (slug.isNotEmpty) 'sort_by': slug,
      if (brandId != 0) 'brand_id': brandId.toString(),
      if (priceFrom.isNotEmpty) 'price_from': priceFrom,
      if (priceTo.isNotEmpty) 'price_to': priceTo,
    });
    return params;
  }

  static Map<String, dynamic> updateUserParams(
      String? firstName, String? lastName, String? middleName) {
    Map<String, dynamic> params = {};
    params.addAll({
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'gender': true,
    });
    return params;
  }

  static Map<String, dynamic> changeLangParams(String language) {
    Map<String, String> params = {};
    params.addAll({
      'first_name': language,
    });
    return params;
  }

  /* Http Parsing */

  static ShowProduct? parseProduct(String? response) {
    if (response == null || response.isEmpty) {
      return null; // Safely return null if the response is empty or null
    }
    dynamic json = jsonDecode(response);
    dynamic data = json['data'];
    return ShowProduct.fromJson(data);
  }

  static User? parseUser(String? response) {
    if (response == null || response.isEmpty) {
      return null;
    }
    dynamic json = jsonDecode(response);
    return UserModel.fromJson(json).user;
  }
}
