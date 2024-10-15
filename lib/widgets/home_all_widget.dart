import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';

class HomeAllWidget extends StatelessWidget {
  const HomeAllWidget({super.key, required this.onPress});

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "all".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
                color: Color(0xFF006266),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 4.w
          ),
          Image.asset(
            "assets/icons/ic_arrow.png",
            width: 24.w,
            height: 24.w,
          )
        ],
      ),
    );
  }
}
