import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Get.find<SplashController>().initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: Container(
                    height: 108.w,
                    width: 108.w,
                    child: Image.asset('assets/images/ic_quyoshli.png'),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Quyoshli",
                  textScaler: TextScaler.linear(1),

                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
