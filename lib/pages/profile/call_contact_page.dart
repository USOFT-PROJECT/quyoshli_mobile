import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/subpage/profile_controller.dart';

showCall(context, ProfileController controller) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.only(top: 32.h, left: 24.w),
      height: 211.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "feedback".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () async {
              await controller.launchUrls("tel:${controller.feedback!.phone}");
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/ic_phone.png",
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(
                  width: 10.w
                ),
                Text(
                  "call_center".tr,
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          GestureDetector(
            onTap: () {
              controller.launchUrls("https://${controller.feedback!.telegramSupport}");
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/ic_telegram.png",
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(width: 10.w),
                Text(
                  "contact_tg".tr,
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
