import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnavailableProductWidget extends StatelessWidget {
  const UnavailableProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 84.h,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF9D0D0),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.red,
                size: 20.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "no_items_info".tr,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Color(0xFF5A0707),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
