import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/cart/branch_model.dart';
import 'package:quyoshli/models/cart/checkout_preview_model.dart';
import 'package:quyoshli/pages/payment/legal_payment_page.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:quyoshli/services/utils_service.dart';

import '../../models/cart/cart_model.dart';
import '../../models/main/region_model.dart';
import '../../models/profile/user_model.dart';
import '../../services/http_service.dart';
import '../payment/payment_page.dart';

class PlacingOrderController extends GetxController {
  late ReadySolutions products;
  CheckoutPreviewResponseModel checkoutPreviewResponse =
      CheckoutPreviewResponseModel(data: CheckoutPreviewData(products: []));

  CheckoutPreviewData? resCheckout;

  bool isDeliverMyself = false;
  bool isInstallMaster = true;
  bool isPhysical = true;

  //physical
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController addressController;

  //address
  late TextEditingController homeController;
  late TextEditingController orienterController;

  //legal
  late TextEditingController legalNameController;
  late TextEditingController innController;
  late TextEditingController fioDirector;
  late TextEditingController bankController;
  late TextEditingController mfoController;
  late TextEditingController bankNumberController;
  late TextEditingController okedController;
  late TextEditingController legalAddressController;
  late TextEditingController emailController;
  late TextEditingController legalPhoneNumber;

  List<RegionModel> regions = [];
  List<BranchModel> branches = [];
  List<City> cities = [];
  int? cityIndex;
  int? regionIndex;
  int branchIndex = 0;
  int installationIndex = 0;

  bool isDataReady = true;
  bool isAddressReady = false;

  User? user;

  int calculateTotalPrice() {
    int basePrice = checkoutPreviewResponse.data?.productPrice ?? 0;
    int delivery = isDeliverMyself
        ? 0
        : (checkoutPreviewResponse.data?.deliveryPrice ?? 0);
    int installation = installationIndex == 1
        ? (checkoutPreviewResponse.data?.installationPrice ?? 0)
        : 0;

    return basePrice + installation + delivery;
  }

  apiLoadUser() async {
    var response =
        await Network.GET(Network.API_GET_USER, Network.paramsEmpty());
    var result = Network.parseUser(response!);
    user = result!;

    phoneController.text = Utils.formatPhoneNumber(user?.phone ?? "");
    if (user!.firstName!.isNotEmpty ||
        user!.lastName!.isNotEmpty ||
        user!.middleName!.isNotEmpty) {
      nameController.text =
          "${user!.firstName ?? ''} ${user!.lastName ?? ''} ${user!.middleName ?? ''}";
    }
    update();
    update();
  }

  init(CartModel cart, bool isSingleProduct) {
    products = isSingleProduct
        ? cart.data!.singleProducts!
        : cart.data!.readySolutions!;

    isAddressReady = isDeliverMyself ? true : false;
    isDataReady = false;
    update();
  }

  getData() async {
    var regionresponse = await Network.GET(Network.REGIONS, {});
    var branchresponse = await Network.GET(Network.API_BRANCHES, {});
    var branchresult = branchDataModelFromJson(branchresponse!);

    branches = branchresult.data ?? [];
    var regionresult = regionModelFromJson(regionresponse!);
    regions = regionresult.data ?? [];
    if (regionIndex != null) {
      cities = regions[regionIndex ?? 0].cities!;
      update();
    }
    update();
  }

  onCityChange(int index) {
    if (regionIndex != null) {
      cityIndex = index;
      update();
      checkout(cities[cityIndex!].id);
    }
  }

  onRegionChange(int? index) {
    regionIndex = index;
    if (regions.isNotEmpty) {
      cityIndex = null;
      cities = regions[regionIndex ?? 0].cities!;
    }
    update();
    checkout(cities[cityIndex!].id);
  }

  onBranchChange(int index) {
    branchIndex = index;
    update();
  }

  changeDelivery(bool deliverType) {
    isDeliverMyself = deliverType;
    update();
  }

  changeClient(bool isClient) {
    cityIndex = null;
    regionIndex = null;
    cities.clear();
    isPhysical = isClient;
    update();
  }

  changeInstallType(index) {
    installationIndex = index;
    update();
  }

  onNameChange(String value) {
    update();
  }

  onLegalChange(String value) {
    update();
  }

  onAddressChange(String value) {
    update();
  }

  final String countryCode = '+998';

  onPhonechange(String value) {
    if (phoneController.text.isEmpty) {
      phoneController.text = countryCode;
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));
    } else if (!phoneController.text.startsWith(countryCode)) {
      phoneController.text =
          countryCode + phoneController.text.replaceAll(countryCode, '');
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));
    }
    update();
  }

  onLegalPhonechange(String value) {
    if (legalNameController.text.isEmpty) {
      legalNameController.text = countryCode;
      legalNameController.selection = TextSelection.fromPosition(
          TextPosition(offset: legalNameController.text.length));
    } else if (!legalNameController.text.startsWith(countryCode)) {
      legalNameController.text =
          countryCode + legalNameController.text.replaceAll(countryCode, '');
      legalNameController.selection = TextSelection.fromPosition(
          TextPosition(offset: legalNameController.text.length));
    }
    update();
  }

  //go to payment
  goToPayment(bool isSingle) {
    var parameters = {
      "type": isSingle ? "single_products" : "ready_solutions",
      "delivery_type": isDeliverMyself ? "pickup" : "delivery",
      "client_type": isPhysical ? "physical" : "legal",
      "client_information": isPhysical
          ? {
              "full_name": nameController.text,
              "phone":
                  phoneController.text.removeAllWhitespace.replaceAll('+', '')
            }
          : {
              'director_full_name': fioDirector.text,
              "company_name": legalNameController.text,
              "inn": innController.text,
              "bank_name": bankController.text,
              "mfo": mfoController.text,
              "payment_account": bankNumberController.text,
              "oked": okedController.text,
              "address": legalAddressController.text,
              // "email": emailController.text,
              "phone":
                  legalPhoneNumber.text.removeAllWhitespace.replaceAll('+', '')
            },
      if (!isDeliverMyself)
        "address": {
          // if (service.isPower!) 'power_id': powers[powerIndex!].id.toString(),

          "city_id": cities[cityIndex ?? 0].id,
          "address": addressController.text,
          "home": homeController.text,
          "landmark": orienterController.text
        },
      if (isDeliverMyself) "branch_id": branches[branchIndex].id,
      "with_installation": installationIndex == 1,
      "payment_type": "",
      if (!isPhysical) "with_didox": true,
      "products": List.generate(
        products.products!.length,
        (index) => {
          "id": products.products![index].productId,
          "count": products.products![index].count
        },
      )
    };

    if (isPhysical) {
      Get.to(() => PhysicalPaymentPage(
            data: parameters,
          ));
    } else {
      Get.to(() => LegalPaymentPage(data: parameters));
    }
  }

  //checkout
  checkout(int? cityId) async {
    var params = {
      "type": "ready_solutions",
      "city_id": cityId,
      "products": List.generate(
        products.products!.length,
        (index) => {
          'id': products.products![index].productId,
          'count': products.products![index].count
        },
      )
    };

    LogService.w(params.toString());
    var response = await Network.POST(Network.API_CHECKOUT_PREVIEW, params);
    LogService.d("response +++++++++++++++ : ${response ?? "no response"}");

    if (response != null) {
      checkoutPreviewResponse = checkoutPreviewResponseModelFromJson(response);
      resCheckout = checkoutPreviewResponse.data;
      LogService.w(checkoutPreviewResponse.data!.installationPrice.toString());
      update();
    }
  }
}
