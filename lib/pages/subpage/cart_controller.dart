import 'package:get/get.dart';
import 'package:quyoshli/models/cart/cart_model.dart';
import 'package:quyoshli/pages/placing_order/placing_order_page.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';

class CartController extends GetxController {
  CartModel cart = CartModel(
      data: Data(
    readySolutions: ReadySolutions(products: []),
    singleProducts: ReadySolutions(products: []),
  ));

  bool isEmpty = false;
  bool isLoading = true;
  bool? isSingle;
  int readySolutionsCount = 0;
  int singleProductsCount = 0;

  bool? singleUnavailableProduct;
  bool? readyUnavailableProduct;

  getData() async {
    var response = await Network.GET(Network.API_CART, {});
    LogService.i(response!);

    singleUnavailableProduct = null;
    readyUnavailableProduct = null;
    var result = cartModelFromJson(response);
    cart = result;

    // Calculate the total count for readySolutions products
    readySolutionsCount = 0; // Reset before summing
    if (cart.data!.readySolutions!.products != null) {
      readySolutionsCount += cart.data!.readySolutions!.products!
          .fold(0, (sum, product) => sum + (product.count ?? 0));
    }

    // Calculate the total count for singleProducts products
    singleProductsCount = 0; // Reset before summing
    if (cart.data!.singleProducts!.products != null) {
      singleProductsCount += cart.data!.singleProducts!.products!
          .fold(0, (sum, product) => sum + (product.count ?? 0));
    }

    // Check if cart is empty
    if (cart.data!.readySolutions!.products!.isNotEmpty ||
        cart.data!.singleProducts!.products!.isNotEmpty) {
      isEmpty = false;
    } else {
      isEmpty = true;
    }

    isLoading = false;
    update();
  }

  removeProducts() {
    if (isSingle != null && isSingle!) {
      cart.data?.singleProducts?.products?.clear();
    } else {
      cart.data?.readySolutions?.products?.clear();
    }
  }

  Future<bool> addItem(id) async {
    var response = await Network.PUT("${Network.API_CART}/$id/add");
    var result = cartModelFromJson(response!);
    cart = result;
    update();
    return true;
  }

  Future<bool> removeItem(id) async {
    var response = await Network.PUT("${Network.API_CART}/$id/decrease");
    var result = cartModelFromJson(response!);
    singleUnavailableProduct = null;
    readyUnavailableProduct = null;
    cart = result;
    update();
    return true;
  }

  Future<void> deleteItem(Product product) async {
    var response = await Network.DEL("${Network.API_CART}/${product.id}");
    singleUnavailableProduct = null;
    readyUnavailableProduct = null;
    getData();
  }

  apply(bool isSingleProduct) async {
    isSingle = isSingleProduct;

    await Get.to(() => PlacingOrderPage(
          cart: cart,
          isSingleProduct: isSingleProduct,
        ));

    if (cart.data!.readySolutions!.products!.isNotEmpty ||
        cart.data!.singleProducts!.products!.isNotEmpty) {
      isEmpty = false;
    } else {
      isEmpty = true;
    }
    update();
  }
}
