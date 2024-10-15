import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:quyoshli/core/app_colors.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget(
      {super.key,
      required this.image,
      required this.onPress,
      required this.title});

  final String title;
  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(
              height: 25.w,
              width: 25.w,
              image,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
