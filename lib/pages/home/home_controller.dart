import 'package:get/get.dart';
import 'package:quyoshli/pages/subpage/cart_controller.dart';

class HomeController extends GetxController {
  void cart() async {
    Get.find<CartController>().getData();
  }
}
