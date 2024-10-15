import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quyoshli/core/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.label,
    required this.onPress,
  });

  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.buttonColor,
      ),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: Text(
            label,
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
