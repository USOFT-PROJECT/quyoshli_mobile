import 'dart:convert';

import 'package:get/get.dart';
import 'package:quyoshli/pages/payment/pament_unsuccess_page.dart';
import 'package:quyoshli/pages/payment/payment_success_page.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/cart/payment_physical_model.dart';
import '../../models/cart/paymet_response_model.dart';

class PaymentController extends GetxController {
  List<System> paymentImg = [];
  bool isPaymentSystem = true;
  PaymentSystemPhysical? paymentSystemPhysical;
  PaymentSystem? paymentSystem;
  List<PaymentType> paymentTypes = [];

  int paymentIndex = 0;

  bool isLoading = false;

  apiLoadPaymentSystem() async {
    isLoading = true;
    try {
      var response = await Network.GET(Network.API_PAYMENT_SYSTEM, {});
      paymentSystemPhysical = paymentSystemsPhysicalFromJson(response!);
      paymentSystem = paymentSystemPhysical?.data;
      paymentImg = paymentSystem!.paymentTypes!.first.systems!;
      paymentTypes.addAll(paymentSystem!.paymentTypes!);
      update();
    } catch (e) {
      LogService.e(e.toString());
    }
    isLoading = false;
    update();
  }

  choosePaymentSystem(int index) {
    paymentIndex = index;
    update();
  }

  pay(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> map = data;
      map['payment_type'] = isPaymentSystem
          ? paymentImg[paymentIndex].title?.toLowerCase()
          : 'cash';
      LogService.i("paramters:  $map");
      //var response = await Network.POST(Network.API_CHECOUT, map);
      var uri = Uri.http(Network.getServer(), Network.API_CHECOUT);
      var response = await Network.client.post(uri, body: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.contains("errors")) {
          Get.off(() => const PaymentUnsuccessPage());
        } else {
          var result = paymentResponseModelFromJson(response.body);
          await launchUrl(Uri.parse(result.data!.payUrl!));
          // Get.off(PaymentSuccessPage(
          //   payment: result,
          // ));
        }
      } else {
        Get.off(() => const PaymentUnsuccessPage());
      }
      LogService.i("payment response : ${response.body}");
    } on Exception catch (e) {
      Get.off(const PaymentUnsuccessPage());
    }
  }

  choosePaymentType(bool isPaymentSystemChosen) {
    isPaymentSystem = isPaymentSystemChosen;
    update();
  }
}
