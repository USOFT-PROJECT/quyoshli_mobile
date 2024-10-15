import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/cart/payment_legal_model.dart';
import 'package:quyoshli/pages/payment/pament_unsuccess_page.dart';
import 'package:quyoshli/pages/payment/payment_success_page.dart';

import '../../models/cart/paymet_response_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class LegalPaymentController extends GetxController {
  bool payWithBank = true;

  PaymentSystemsLegal? paymentSystemPhysical;
  PaymentSystem? paymentSystem;
  List<PaymentType> paymentTypes = [];

  apiLoadPaymentSystem() async {
    try {
      var response = await Network.GET(Network.API_PAYMENT_LEGAL, {});
      paymentSystemPhysical = paymentSystemsLegalFromJson(response!);
      paymentSystem = paymentSystemPhysical?.data;
      paymentTypes.addAll(paymentSystem!.paymentTypes!);
      update();
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  choosePaymentType(bool isPaymentSystemChosen) {
    payWithBank = isPaymentSystemChosen;
    update();
  }

  TextEditingController companyName = TextEditingController();
  TextEditingController inn = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController fioDirector = TextEditingController();

  TextEditingController mfo = TextEditingController();
  TextEditingController oked = TextEditingController();
  TextEditingController legalAddress = TextEditingController();

  bool withDidox = true;

  onDioxChange(bool value) {
    withDidox = value;
    update();
  }

  init(Map<String, dynamic> data) {
    fioDirector.text = data['client_information']['director_full_name'];
    companyName.text = data['client_information']['company_name'];
    inn.text = data['client_information']['inn'];
    bank.text = data['client_information']['bank_name'];
    mfo.text = data['client_information']['mfo'];
    oked.text = data['client_information']['oked'];
    legalAddress.text = data['client_information']['address'];
  }

  pay(Map<String, dynamic> data) async {
    LogService.w(data.toString());
    Map<String, dynamic> map = data;
    if (payWithBank) map['payment_type'] = 'bank';
    if (!payWithBank) map['payment_type'] = 'cash';
    if (!withDidox && payWithBank) {
      map['with_didox'] = true;
    } else {
      map['with_didox'] = false;
    }
    try {
      var response = await Network.POST(Network.API_CHECOUT, map);
      var result = paymentResponseModelFromJson(response!);
      LogService.i("payment response : $response");
      Get.off(() => PaymentSuccessPage(
            payment: result,
          ));
    } on Exception catch (e) {
      Get.off(() => const PaymentUnsuccessPage());
    }
  }
}
