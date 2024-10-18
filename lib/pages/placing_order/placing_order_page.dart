import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/models/cart/cart_model.dart';
import 'package:quyoshli/pages/placing_order/placing_order_controller.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/branche_widget.dart';
import 'package:quyoshli/widgets/custom_menu_button.dart';
import 'package:quyoshli/widgets/custom_sliver_app_bar.dart';
import 'package:quyoshli/widgets/custom_textfield.dart';
import 'package:quyoshli/widgets/installation_widget.dart';
import 'package:styled_divider/styled_divider.dart';

import '../../widgets/custom_button_widget.dart';

class PlacingOrderPage extends StatefulWidget {
  const PlacingOrderPage(
      {super.key, required this.cart, required this.isSingleProduct});

  final CartModel cart;
  final bool isSingleProduct;

  @override
  State<PlacingOrderPage> createState() => _PlacingOrderPageState();
}

class _PlacingOrderPageState extends State<PlacingOrderPage> {
  final controller = Get.find<PlacingOrderController>();

  @override
  void initState() {
    controller.init(widget.cart, widget.isSingleProduct);
    controller.checkout(null);
    controller.getData();
    controller.apiLoadUser();
    super.initState();

    controller.phoneController = TextEditingController(text: '+998 ');
    controller.nameController = TextEditingController();

    //legal
    controller.legalNameController = TextEditingController();
    controller.fioDirector = TextEditingController();
    controller.legalPhoneNumber = TextEditingController(text: '+998 ');
    controller.bankNumberController = TextEditingController();
    controller.legalAddressController = TextEditingController();
    controller.bankNumberController = TextEditingController();
    controller.innController = TextEditingController();
    controller.okedController = TextEditingController();
    controller.emailController = TextEditingController();
    controller.mfoController = TextEditingController();
    controller.bankController = TextEditingController();

    //address
    controller.addressController = TextEditingController();
    controller.orienterController = TextEditingController();
    controller.homeController = TextEditingController();
  }

  @override
  void dispose() {
    Utils.phoneNumberMask.clear();

    //physical
    controller.phoneController.clear();
    controller.nameController.clear();

    //legal
    controller.legalPhoneNumber.clear();
    controller.bankNumberController.clear();
    controller.legalAddressController.clear();
    controller.bankNumberController.clear();
    controller.innController.clear();
    controller.okedController.clear();
    controller.emailController.clear();
    controller.mfoController.clear();
    controller.bankController.clear();

    //address
    controller.addressController.clear();
    controller.orienterController.clear();
    controller.homeController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlacingOrderController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // SliverAppBar with back button and title
                    CustomSliverAppBar(
                      title: "placing_order".tr,
                      isLeading: true,
                    ),

                    // Form section
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 8.h, right: 16.w, left: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Delivery Type
                                  SizedBox(
                                    // height: 128.h,
                                    // width: double.infinity,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "delivery_type".tr,
                                              textScaler: TextScaler.linear(1),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16.h),
                                        Container(
                                          padding: EdgeInsets.all(4.w),
                                          height: 90.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: const Color.fromRGBO(
                                                233, 233, 233, 1),
                                          ),
                                          child: Row(
                                            children: [
                                              //delivery
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .changeDelivery(false);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      color: !controller
                                                              .isDeliverMyself
                                                          ? Colors.white
                                                          : const Color
                                                              .fromRGBO(
                                                              233, 233, 233, 1),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/ic_delivery.svg",
                                                          colorFilter: !controller
                                                                  .isDeliverMyself
                                                              ? const ColorFilter
                                                                  .mode(
                                                                  Color.fromRGBO(
                                                                      1,
                                                                      162,
                                                                      168,
                                                                      1),
                                                                  BlendMode
                                                                      .srcIn)
                                                              : const ColorFilter
                                                                  .mode(
                                                                  Color
                                                                      .fromRGBO(
                                                                          71,
                                                                          71,
                                                                          71,
                                                                          1),
                                                                  BlendMode
                                                                      .srcIn),
                                                        ),
                                                        Text(
                                                          "delivery".tr,
                                                          textScaler:
                                                              TextScaler.linear(
                                                                  1),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: !controller
                                                                    .isDeliverMyself
                                                                ? const Color
                                                                    .fromRGBO(1,
                                                                    162, 168, 1)
                                                                : const Color
                                                                    .fromRGBO(
                                                                    71,
                                                                    71,
                                                                    71,
                                                                    1),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //not delivery
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .changeDelivery(true);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      color: controller
                                                              .isDeliverMyself
                                                          ? Colors.white
                                                          : const Color
                                                              .fromRGBO(
                                                              233, 233, 233, 1),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        //delivery
                                                        SvgPicture.asset(
                                                          "assets/icons/ic_box.svg",
                                                          colorFilter: controller
                                                                  .isDeliverMyself
                                                              ? const ColorFilter
                                                                  .mode(
                                                                  Color.fromRGBO(
                                                                      1,
                                                                      162,
                                                                      168,
                                                                      1),
                                                                  BlendMode
                                                                      .srcIn)
                                                              : const ColorFilter
                                                                  .mode(
                                                                  Color
                                                                      .fromRGBO(
                                                                          71,
                                                                          71,
                                                                          71,
                                                                          1),
                                                                  BlendMode
                                                                      .srcIn),
                                                        ),
                                                        Text(
                                                          "pickup".tr,
                                                          textScaler:
                                                              TextScaler.linear(
                                                                  1),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: controller
                                                                    .isDeliverMyself
                                                                ? const Color
                                                                    .fromRGBO(1,
                                                                    162, 168, 1)
                                                                : const Color
                                                                    .fromRGBO(
                                                                    71,
                                                                    71,
                                                                    71,
                                                                    1),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 32.h),

                                  // Client Type

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "client".tr,
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      Container(
                                        padding: EdgeInsets.all(4.w),
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: const Color.fromRGBO(
                                              233, 233, 233, 1),
                                        ),
                                        child: Row(
                                          children: [
                                            //pisical
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.changeClient(true);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                    color: controller.isPhysical
                                                        ? Colors.white
                                                        : const Color.fromRGBO(
                                                            233, 233, 233, 1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "physical".tr,
                                                      textScaler:
                                                          TextScaler.linear(1),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //yuridic
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .changeClient(false);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                    color: !controller
                                                            .isPhysical
                                                        ? Colors.white
                                                        : const Color.fromRGBO(
                                                            233, 233, 233, 1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "legal".tr,
                                                      textScaler:
                                                          TextScaler.linear(1),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),

                                  // Form fields for physical
                                  if (controller.isPhysical)
                                    Column(
                                      children: [
                                        CustomTextField(
                                          label: "full_name".tr,
                                          textEditingController:
                                              controller.nameController,
                                          onChange: controller.onNameChange,
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextField(
                                          label: "phone".tr,
                                          formatter: Utils.phoneNumberMask,
                                          textEditingController:
                                              controller.phoneController,
                                          type: TextInputType.phone,
                                          onChange: controller.onPhonechange,
                                        )
                                      ],
                                    ),

                                  //for legal
                                  if (!controller.isPhysical)
                                    Column(
                                      children: [
                                        CustomTextField(
                                          label: "company_name".tr,
                                          textEditingController:
                                              controller.legalNameController,
                                          maxLength: 50,
                                          maxLines: 1,
                                          onChange: controller.onLegalChange,
                                          isValid: controller
                                                      .legalNameController
                                                      .text
                                                      .length >
                                                  3 ||
                                              controller.legalNameController
                                                  .text.isEmpty,
                                          errorText: "company_length".tr,
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextField(
                                          label: "inn".tr,
                                          textEditingController:
                                              controller.innController,
                                          type: TextInputType.number,
                                          maxLength: 9,
                                          isValid: controller.innController.text
                                                      .length >=
                                                  8 ||
                                              controller
                                                  .innController.text.isEmpty,
                                          errorText: "INN 8 raqam yoki koproq",
                                          onChange: controller.onLegalChange,
                                        ),
                                        SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "director_fio".tr,
                                          textEditingController:
                                              controller.fioDirector,
                                          maxLength: 50,
                                          maxLines: 1,
                                          onChange: controller.onLegalChange,
                                          capitalization:
                                              TextCapitalization.words,
                                        ),
                                        SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "bank".tr,
                                          maxLines: 1,
                                          textEditingController:
                                              controller.bankController,
                                          onChange: controller.onLegalChange,
                                        ),
                                        SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "mfo".tr,
                                          textEditingController:
                                              controller.mfoController,
                                          type: TextInputType.number,
                                          maxLength: 5,
                                          isValid: controller.mfoController.text
                                                      .length >=
                                                  4 ||
                                              controller
                                                  .mfoController.text.isEmpty,
                                          errorText: "mfo_length".tr,
                                          onChange: controller.onLegalChange,
                                        ),
                                        SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "acc_number".tr,
                                          textEditingController:
                                              controller.bankNumberController,
                                          type: TextInputType.number,
                                          maxLength: 20,
                                          isValid: controller
                                                      .bankNumberController
                                                      .text
                                                      .length ==
                                                  20 ||
                                              controller.bankNumberController
                                                  .text.isEmpty,
                                          errorText: "invalid_bank_number".tr,
                                          onChange: controller.onLegalChange,
                                        ),
                                        SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "oked".tr,
                                          textEditingController:
                                              controller.okedController,
                                          type: TextInputType.number,
                                          maxLength: 15,
                                          isValid: controller.okedController
                                                      .text.length >=
                                                  3 ||
                                              controller
                                                  .okedController.text.isEmpty,
                                          errorText: "invalid_oked".tr,
                                          onChange: controller.onLegalChange,
                                        ),
                                        SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "legal_address".tr,
                                          maxLines: 1,
                                          textEditingController:
                                              controller.legalAddressController,
                                          onChange: controller.onLegalChange,
                                        ),
                                        SizedBox(height: 16.h),
                                        // CustomTextField(
                                        //   label: "email".tr,
                                        //   maxLines: 1,
                                        //   textEditingController:
                                        //       controller.emailController,
                                        //   onChange: (value) {
                                        //     controller.onLegalChange(value);
                                        //   },
                                        //   isValid: controller.emailController
                                        //           .text.isNotEmpty
                                        //       ? Utils.isValidEmail(controller
                                        //           .emailController.text)
                                        //       : true,
                                        //   errorText: "invalid_email".tr,
                                        // ),
                                        // SizedBox(height: 16.h),
                                        CustomTextField(
                                          label: "phone".tr,
                                          textEditingController:
                                              controller.legalPhoneNumber,
                                          formatter: Utils.phoneNumberMask,
                                          type: TextInputType.phone,
                                          onChange:
                                              controller.onLegalPhonechange,
                                          isValid: controller.legalPhoneNumber
                                                      .text.length ==
                                                  17 ||
                                              controller.legalPhoneNumber.text
                                                      .length ==
                                                  5,
                                          errorText: "invalid_phone".tr,
                                        ),
                                        SizedBox(height: 16.h),
                                      ],
                                    ),

                                  SizedBox(height: 32.h),

                                  // if delivery
                                  if (!controller.isDeliverMyself)
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "delivery_address".tr,
                                                textScaler:
                                                    TextScaler.linear(1),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.h),

                                          //region
                                          CustomMenuButton(
                                            index: controller.regionIndex,
                                            options: controller.regions,
                                            onChange: controller.onRegionChange,
                                            label: "region".tr,
                                          ),

                                          SizedBox(height: 16.h),

                                          // Dropdown for city
                                          CustomMenuButton(
                                            index: controller.cityIndex,
                                            options: controller.cities,
                                            onChange: controller.onCityChange,
                                            label: "city".tr,
                                          ),
                                          // Dropdown for City
                                          SizedBox(height: 16.h),
                                          CustomTextField(
                                            label: 'address'.tr,
                                            textEditingController:
                                                controller.addressController,
                                            onChange:
                                                controller.onAddressChange,
                                          ),
                                          SizedBox(height: 16.h),
                                          CustomTextField(
                                            label: 'home_number'.tr,
                                            textEditingController:
                                                controller.homeController,
                                            type: TextInputType.number,
                                            onChange:
                                                controller.onAddressChange,
                                          ),
                                          SizedBox(height: 16.h),

                                          CustomTextField(
                                            label: 'landmark'.tr,
                                            textEditingController:
                                                controller.orienterController,
                                            onChange:
                                                controller.onAddressChange,
                                          ),
                                        ],
                                      ),
                                    ),

                                  //if delivery
                                  if (controller.isDeliverMyself)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "pickup_point".tr,
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        BranchWidget(
                                          branches: controller.branches,
                                          itemIndex: controller.branchIndex,
                                          onChange: controller.onBranchChange,
                                        )
                                      ],
                                    ),

                                  SizedBox(height: 32.h),

                                  // Установка
                                  if (!widget.isSingleProduct)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "installation".tr,
                                              textScaler: TextScaler.linear(1),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16.h),
                                        InstallationWidget(
                                          index: controller.installationIndex,
                                          onChange:
                                              controller.changeInstallType,
                                        ),
                                        SizedBox(height: 32.h),
                                      ],
                                    ),

                                  SizedBox(
                                    // color: Colors.green,

                                    child: Column(
                                      children: [
                                        SizedBox(
                                          // height: 24,
                                          child: Row(
                                            children: [
                                              Text(
                                                "your_order".tr,
                                                textScaler:
                                                    TextScaler.linear(1),
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 16.h),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Column(
                                          children: [
                                            //show list of products
                                            ...List.generate(
                                              controller.checkoutPreviewResponse
                                                  .data!.products!.length,
                                              (index) {
                                                var product = controller
                                                    .checkoutPreviewResponse
                                                    .data!
                                                    .products![index];
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  // height: 40,
                                                  width: double.infinity,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2)
                                                              .w,
                                                          child: Text(
                                                            "${product.count}x ${product.name}",
                                                            textScaler:
                                                                TextScaler
                                                                    .linear(1),
                                                            // "${(product.count! * product.price!.toInt()).decimal} сум",
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .textColor,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 16.w),
                                                      Text(
                                                        "${(product.count! * product.price!.toInt()).decimal} ${"currency".tr}",
                                                        // "${product.price?.decimal.toString()} сум",
                                                        textScaler:
                                                            TextScaler.linear(
                                                                1),
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .textColor,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 15.5.h),

                                        const StyledDivider(
                                          thickness: 1,
                                          lineStyle: DividerLineStyle.dashed,
                                          color: Colors.grey,
                                        ),

                                        SizedBox(height: 15.5.h),

                                        if (!controller.isDeliverMyself)
                                          SizedBox(
                                            height: 20.h,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "delivery".tr,
                                                    textScaler:
                                                        TextScaler.linear(1),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  // "${Utils.putSpace(controller.deliveryPrice.toString())} сум",
                                                  "${controller.checkoutPreviewResponse.data!.deliveryPrice?.decimal.toString()} ${"currency".tr}",
                                                  textScaler:
                                                      TextScaler.linear(1),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        SizedBox(height: 12.h),
                                        if (controller.installationIndex == 1)
                                          SizedBox(
                                            height: 20.h,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "installation".tr,
                                                    textScaler:
                                                        TextScaler.linear(1),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${controller.resCheckout?.installationPrice?.decimal ?? 0} ${"currency".tr}",
                                                  textScaler:
                                                      TextScaler.linear(1),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        SizedBox(height: 15.5.h),

                                        const StyledDivider(
                                          height: 1,
                                          lineStyle: DividerLineStyle.dashed,
                                          color:
                                              Color.fromRGBO(226, 226, 226, 1),
                                        ),

                                        SizedBox(height: 15.5.h),

                                        // Итого:
                                        SizedBox(
                                          height: 32.h,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "total".tr,
                                                  textScaler:
                                                      TextScaler.linear(1),
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${controller.calculateTotalPrice().decimal} ${"currency".tr}",
                                                textScaler:
                                                    TextScaler.linear(1),
                                                style: TextStyle(
                                                  fontSize: 24.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 32.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // cost and pay button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 80.h,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(226, 226, 226, 1),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Color.fromRGBO(226, 226, 226, 1),
                      width: 1,
                    ),
                  ),
                  // color: Colors.green,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.checkoutPreviewResponse.data != null
                            ? "${controller.calculateTotalPrice().decimal} ${"currency".tr}"
                            : '',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Оформить button
                    (controller.isDeliverMyself
                                ? controller.branchIndex != null
                                : (controller.cityIndex != null &&
                                    controller.regionIndex != null &&
                                    controller
                                        .addressController.text.isNotEmpty)) &&
                            (controller.isPhysical
                                ? (controller.nameController.text.isNotEmpty &&
                                    controller.phoneController.text.length ==
                                        17)
                                : (controller
                                        .legalNameController.text.isNotEmpty &&
                                    (controller
                                            .innController.text.length ==
                                        9) &&
                                    (controller
                                            .mfoController.text.length >=
                                        4) &&
                                    (controller
                                            .bankNumberController.text.length ==
                                        20) &&
                                    (controller.fioDirector.text.length >= 5) &&
                                    (controller
                                            .legalPhoneNumber.text.length ==
                                        17) &&
                                    (controller.legalAddressController.text
                                        .isNotEmpty) &&
                                    (controller.okedController.text.length >=
                                        3) &&
                                    controller.bankController.text.isNotEmpty))
                        ? CustomButtonWidget(
                            label: "design".tr,
                            onPress: () {
                              controller.goToPayment(widget.isSingleProduct);
                            },
                          )
                        : Container(
                            height: 48.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xff1111111f),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              "design".tr,
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
