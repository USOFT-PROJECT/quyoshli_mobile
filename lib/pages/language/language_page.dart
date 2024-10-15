import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import '../../widgets/custom_button_widget.dart';
import 'language_controller.dart';

class LanguagePage extends StatefulWidget {
  static const String id = "language_page";

  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final languageController = Get.find<LanguageController>();

  @override
  void didUpdateWidget(covariant LanguagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    languageController.setLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: GetBuilder<LanguageController>(
        builder: (_) {
          return Container(
            margin: EdgeInsets.only(top: 107.h, left: 16.w, right: 16.w),
            width: (MediaQuery.of(context).size.width).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo
                SizedBox(
                  // height: 152.h,
                  width: 232.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "logo",
                        child: SizedBox(
                          height: 108.w,
                          width: 108.w,
                          child: Image.asset('assets/images/ic_quyoshli.png'),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        // height: 28.h,
                        child: Center(
                          child: Text(
                            textScaler: TextScaler.linear(1),
                            "Quyoshli",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 56.h),

                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.h,
                        child: Text(
                          "select_lang".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // button ru
                      GestureDetector(
                        onTap: () {
                          languageController.changeLanguage('ru');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: !languageController.isUzbek
                                ? const Color(0xFFCBFAFC)
                                : const Color.fromRGBO(231, 234, 231, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24.w,
                                    width: 24.w,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/flag_ru.png'),
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    "russian".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              !languageController.isUzbek
                                  ? SizedBox(
                                      width: 24.w,
                                      height: 24.w,
                                      child: Icon(
                                        Icons.check,
                                        color: Color.fromRGBO(0, 135, 0, 1),
                                      ),
                                    )
                                  : Text(
                                      "Русский",
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // button uz
                      GestureDetector(
                        onTap: () {
                          languageController.changeLanguage('uz');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: languageController.isUzbek
                                ? const Color(0xFFCBFAFC)
                                : const Color.fromRGBO(231, 234, 231, 1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24.w,
                                    width: 24.w,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/flag_uz.png'),
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    "uzbek".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              languageController.isUzbek
                                  ? SizedBox(
                                      width: 24.w,
                                      height: 24.w,
                                      child: Icon(
                                        Icons.check,
                                        color: Color.fromRGBO(0, 135, 0, 1),
                                      ),
                                    )
                                  : Text(
                                      "O`zbekcha",
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      CustomButtonWidget(
                          label: "select".tr,
                          onPress: () {
                            languageController.callNextPage();
                          }),
                      // select button
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
