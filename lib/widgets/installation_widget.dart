import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';

class InstallationWidget extends StatelessWidget {
  const InstallationWidget(
      {super.key, required this.index, required this.onChange});

  final int index;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //myself
        GestureDetector(
          onTap: () {
            onChange(0);
          },
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
                color: index == 0
                    ? const Color(0xFFCBFAFC)
                    : const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(12.r),
                border: index == 0
                    ? Border.all(color: const Color(0xFF006266))
                    : null),
            child: Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: index,
                  onChanged: (value) {
                    onChange(value);
                  },
                  activeColor: const Color(0xFF01A2A8),
                ),
                Expanded(
                  child: Text(
                    "self_installation".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.h
        ),
        //master
        GestureDetector(
          onTap: () {
            onChange(1);
          },
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: index == 1
                  ? const Color(0xFFCBFAFC)
                  : const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(12),
              border: index == 1
                  ? Border.all(color: const Color(0xFF006266))
                  : Border.all(color: Colors.transparent),
            ),
            child: Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: index,
                  onChanged: (value) {
                    onChange(value);
                  },
                  activeColor: const Color(0xFF01A2A8),
                ),
                Expanded(
                  child: Text(
                    "with_installation".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
