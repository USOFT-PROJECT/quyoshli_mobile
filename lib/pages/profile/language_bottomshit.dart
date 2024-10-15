import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/subpage/profile_controller.dart';

import '../../core/app_colors.dart';

showLanguage(context, ProfileController controller, bool isUzbekSelected) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => GetBuilder<ProfileController>(
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 32.h, left: 24.w),
        height: 211.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28.r),
            topLeft: Radius.circular(28.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "language".tr,
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 32.h),

            //rus
            GestureDetector(
              onTap: () {
                controller.changeLanguage(false, 'ru');
              },
              child: Row(
                children: [
                  isUzbekSelected
                      ? Container(
                          alignment: Alignment.center,
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF777777), width: 2.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF01A2A8), width: 2.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: const Color(0xFF01A2A8),
                            ),
                          ),
                        ),
                  SizedBox(width: 10.w),
                  Text(
                    "russian".tr,
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

            SizedBox(height: 16.h),
            //uzb
            GestureDetector(
              onTap: () {
                controller.changeLanguage(true, 'uz');
              },
              child: Row(
                children: [
                  isUzbekSelected
                      ? Container(
                          alignment: Alignment.center,
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF01A2A8), width: 2.w),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: const Color(0xFF01A2A8)),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF777777), width: 2.w),
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                  SizedBox(width: 10.w),
                  Text(
                    "uzbek".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
