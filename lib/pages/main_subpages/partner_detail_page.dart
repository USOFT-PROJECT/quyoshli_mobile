import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/partners_model.dart';
import 'package:quyoshli/pages/main_subpages/partner_detail_controller.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/inactive_button.dart';

import '../../core/app_colors.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_menu_button.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import '../../widgets/custom_textfield.dart';

class PartnerDetailPage extends StatefulWidget {
  const PartnerDetailPage({super.key, required this.partner});

  static const String id = "leader_page";
  final PartnerModel partner;

  @override
  State<PartnerDetailPage> createState() => _PartnerDetailPageState();
}

class _PartnerDetailPageState extends State<PartnerDetailPage> {
  final controller = Get.find<PartnerDetailController>();
  late PartnerModel partner;

  @override
  void initState() {
    partner = widget.partner;
    controller.getPartnerDetails(partner.id!);
    controller.getData();
    controller.apiLoadUser();
    super.initState();
  }

  @override
  void dispose() {
    controller.commentText.clear();
    controller.nameTextField.clear();
    controller.phoneField.clear();
    controller.priceText.clear();
    Utils.phoneNumberMask.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerDetailController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //body
            Expanded(
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(title: partner.name!, isLeading: true),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 8.h, right: 16.w, left: 16.w, bottom: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //text about how to use
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/icons/ic_how_to_use.png",
                                width: 20.w,
                                height: 30.h,
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  controller.partner.data?.description ?? "",
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w400),
                                  maxLines: null,
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 16.h),

                          //how to use button

                          if (controller.partner.data?.videoUrl != null)
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFF777777),
                                ),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  controller.openYouTube();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/ic_video.png",
                                      height: 20.w,
                                      width: 20.w,
                                    ),
                                    SizedBox(width: 16.w),
                                    Text(
                                      "how_use".tr,
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        color: Color(0xFF006266),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Image.asset(
                                      "assets/icons/ic_share.png",
                                      width: 20.w,
                                      height: 20.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(height: 32.h),
                          Text(
                            "information".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp),
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
                          SizedBox(height: 16.h),
                          CustomTextField(
                            label: "phone".tr,
                            textEditingController: controller.phoneField,
                            onChange: controller.onPhonechange,
                            type: TextInputType.phone,
                            formatter: Utils.phoneNumberMask,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            label: "full_name".tr,
                            textEditingController: controller.nameTextField,
                            onChange: controller.onChange,
                            maxLines: 1,
                          ),
                          SizedBox(height: 16.h),
                          if (partner.isPrice!)
                            CustomTextField(
                              textEditingController: controller.priceText,
                              label: "price_per_service".tr,
                              type: TextInputType.number,
                              onChange: controller.onChange,
                              maxLines: 1,
                            ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 128.h,
                            child: CustomTextField(
                              label: "comment".tr,
                              textEditingController: controller.commentText,
                              onChange: controller.onChange,
                            ),
                          ),
                          SizedBox(height: 80.h)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///confirm
            ///
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
                            controller.regionIndex != null &&
                            controller.cityIndex != null &&
                            (controller.partner.data?.isPrice != null
                                ? controller.partner.data!.isPrice!
                                    ? controller.priceText.text.isNotEmpty
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
