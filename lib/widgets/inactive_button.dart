import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InactiveButton extends StatelessWidget {
  const InactiveButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color.fromRGBO(17, 17, 17, 0.12),
      ),
      child: Text(
        text,
        textScaler: TextScaler.linear(1),
        style: TextStyle(
            color: Color.fromRGBO(17, 17, 17, 0.32),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
