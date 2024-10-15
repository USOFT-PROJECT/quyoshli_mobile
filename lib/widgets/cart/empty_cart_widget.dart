import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';

Widget emptyCartWidget(BuildContext context, PageController pageController) {
  return Center(
    child: Container(
      height: 290.h,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
            width: 80.w,
            child: Image.asset("assets/images/im_cart.png"),
          ),
          SizedBox(height: 24.h),
          Text(
            "empty_info_basket".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "feedback_fv".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 17.h),
          SizedBox(
            width: 133.w,
            child: CustomButtonWidget(
              label: "go_home".tr,
              onPress: () {
                pageController.jumpToPage(0);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
