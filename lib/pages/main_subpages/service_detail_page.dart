import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/services_model.dart';
import 'package:quyoshli/pages/main_subpages/service_detail_controller.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/inactive_button.dart';

import '../../core/app_colors.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_menu_button.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import '../../widgets/custom_textfield.dart';

class ServiceDetailPage extends StatefulWidget {
  static const String id = "diagnostics_page";
  final ServiceModel service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final controller = Get.find<ServiceDetailController>();

  @override
  void initState() {
    controller.apiLoadUser();
    controller.init(widget.service);
    controller.getData();
    super.initState();
  }

  @override
  void dispose() {
    controller.phoneField.clear();
    controller.nameTextField.clear();
    controller.commentText.clear();
    Utils.phoneNumberMask.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ///bfy
            Expanded(
              child: CustomScrollView(
                slivers: [
                  ///app bar
                  CustomSliverAppBar(
                      title: controller.service.name ?? "", isLeading: true),

                  ///body
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          top: 8.h, left: 16.w, right: 16.w, bottom: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "service_details".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor),
                          ),
                          SizedBox(height: 16.h),
                          if (controller.service.isPower!)
                            CustomMenuButton(
                              index: controller.powerIndex,
                              options: controller.powers,
                              onChange: controller.onPowerChange,
                              label: "power".tr,
                            ),
                          if (controller.service.withProblem!)
                            Column(
                              children: [
                                SizedBox(height: 16.h),
                                CustomMenuButton(
                                  index: controller.problemIndex,
                                  options: controller.problems,
                                  onChange: controller.onProblemChange,
                                  label: "problem".tr,
                                ),
                              ],
                            ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 128.h,
                            width: double.infinity,
                            child: CustomTextField(
                              label: "comment".tr,
                              textEditingController: controller.commentText,
                              onChange: controller.onChange,
                              maxLength: null,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Text(
                            "address".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomMenuButton(
                            index: controller.regionIndex,
                            options: controller.regions,
                            onChange: controller.onRegionChange,
                            label: "region".tr,
                          ),
                          SizedBox(height: 16.h),
                          CustomMenuButton(
                            index: controller.cityIndex,
                            options: controller.cities,
                            onChange: controller.onCityChange,
                            label: "city".tr,
                          ),
                          SizedBox(height: 32.h),
                          Text(
                            "client".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor),
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            label: "full_name".tr,
                            textEditingController: controller.nameTextField,
                            onChange: controller.onChange,
                            maxLines: 1,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            label: "phone".tr,
                            textEditingController: controller.phoneField,
                            formatter: Utils.phoneNumberMask,
                            type: TextInputType.phone,
                            onChange: controller.onPhonechange,
                          ),
                          SizedBox(height: 50.h)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                const Divider(),
                Container(
                  padding: EdgeInsets.only(
                      top: 10.h, left: 16.w, right: 16.w, bottom: 32.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: controller.phoneField.text.length == 17 &&
                            controller.nameTextField.text.isNotEmpty &&
                            controller.cityIndex != null &&
                            controller.regionIndex != null &&
                            (controller.service.isPower != null
                                ? controller.service.isPower!
                                    ? controller.powerIndex != null
                                        ? true
                                        : false
                                    : true
                                : true) &&
                            (controller.service.withProblem != null
                                ? controller.service.withProblem!
                                    ? controller.problemIndex != null
                                        ? true
                                        : false
                                    : true
                                : true)
                        ? CustomButtonWidget(
                            label: 'send_request'.tr,
                            onPress: () {
                              controller.appLy();
                            },
                          )
                        : InactiveButton(text: 'send_request'.tr),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
