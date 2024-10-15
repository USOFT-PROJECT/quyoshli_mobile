import 'package:get/get.dart';
import 'package:quyoshli/pages/login/login_controller.dart';
import 'package:quyoshli/pages/otpsms/otpsms_controller.dart';
import 'package:quyoshli/pages/profile/my_requests_controller.dart';
import 'package:quyoshli/pages/splash/splash_controller.dart';
import 'package:quyoshli/pages/subpage/catalog_controller.dart';
import 'package:quyoshli/pages/subpage/main_controller.dart';
import 'package:quyoshli/pages/subpage/profile_controller.dart';

import '../pages/catalog/product_detail_controller.dart';
import '../pages/catalog/products_controller.dart';
import '../pages/home/home_controller.dart';
import '../pages/language/language_controller.dart';
import '../pages/main_subpages/all_product_controller.dart';
import '../pages/main_subpages/banner_detail_controller.dart';
import '../pages/main_subpages/brand_products_contoller.dart';
import '../pages/main_subpages/favourite_controller.dart';
import '../pages/main_subpages/partner_detail_controller.dart';
import '../pages/main_subpages/partners_page_controller.dart';
import '../pages/main_subpages/search_controller.dart';
import '../pages/main_subpages/service_detail_controller.dart';
import '../pages/main_subpages/service_page_controller.dart';
import '../pages/main_subpages/useful_controller.dart';
import '../pages/main_subpages/usefull_detail_controller.dart';
import '../pages/main_subpages/usefull_sub_controller.dart';
import '../pages/payment/legal_payment_controller.dart';
import '../pages/payment/payment_controller.dart';
import '../pages/payment/unsuccessfull_payment_controller.dart';
import '../pages/placing_order/placing_order_controller.dart';
import '../pages/profile/my_info_controller.dart';
import '../pages/profile/my_orders_controller.dart';
import '../pages/registration/registration_controller.dart';
import '../pages/subpage/cart_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);

    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => MyInfoController(), fenix: true);
    Get.lazyPut(() => OtpSmsController(), fenix: true);

    //register controller
    Get.lazyPut(() => RegistrationController(), fenix: true);

    //ordering controllers
    Get.lazyPut(() => PlacingOrderController(), fenix: true);

    //payment
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => LegalPaymentController(), fenix: true);
    Get.lazyPut(() => UnsuccessfullPaymentController(), fenix: true);

    //main
    Get.lazyPut(() => LanguageController(), fenix: true);
    Get.lazyPut(() => FavouriteController(), fenix: true);
    Get.lazyPut(() => LanguageController(), fenix: true);
    Get.lazyPut(() => BannerDetailController(), fenix: true);
    Get.lazyPut(() => PartnerDetailController(), fenix: true);
    Get.lazyPut(() => ServiceDetailController(), fenix: true);
    Get.lazyPut(() => SearchPageController(), fenix: true);
    Get.lazyPut(() => UsefulController(), fenix: true);
    Get.lazyPut(() => UsefullSubController(), fenix: true);
    Get.lazyPut(() => UsefullDetailController(), fenix: true);
    Get.lazyPut(() => BrandProductsController(), fenix: true);
    Get.lazyPut(() => AllProductController(), fenix: true);

    //profile
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MyInfoController(), fenix: true);
    Get.lazyPut(() => MyOrdersController(), fenix: true);
    Get.lazyPut(() => MyRequestsController(), fenix: true);

    //service
    Get.lazyPut(() => ServicePageController(), fenix: true);
    Get.lazyPut(() => PartnersPageController(), fenix: true);

    //catalog
    Get.lazyPut(() => ProductsController(), fenix: true);
    Get.lazyPut(() => CatalogController(), fenix: true);

    //cart
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => ProductDetailController(), fenix: true);
  }
}
