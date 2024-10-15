import 'package:get/get.dart';
import 'package:quyoshli/pages/profile/request_show_page.dart';

import 'order_check_page.dart';

class MyOrdersController extends GetxController {
  goToActiveOrderCheckPage(String orderId) {
    Get.to(OrderCheckPage(id: orderId));
  }
//
// goToActiveWorksCheckPage(){
//   Get.to(RequestShowPage());
// }
}
