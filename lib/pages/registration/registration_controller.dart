import 'package:get/get.dart';

class RegistrationController extends GetxController {
  bool isClient = true;

  chooseMasterOrClient(bool isClientChosen) {
    isClient = isClientChosen;
    update();
  }

  bool isPhysicPerson = true;

  choosePersonType(bool isPhsyic) {
    isPhysicPerson = isPhsyic;
    update();
  }

  goToOrdering() {
    //Get.off(const PlacingOrderPage());
  }
}
