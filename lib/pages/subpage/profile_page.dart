import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/subpage/profile_controller.dart';
import 'package:quyoshli/services/log_service.dart';

import '../../core/app_colors.dart';
import '../profile/call_contact_page.dart';
import '../profile/language_bottomshit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.apiLoadUser();
    LogService.i("Welcome to Profile");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (profileController.isRegistered) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      // profile
                      GestureDetector(
                        onTap: () {
                          controller.goMyInfoPage();
                        },
                        child: Container(
                          height: 104.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 24.h,
                          ),
                          child: Row(
                            children: [
                              // profile image
                              Container(
                                padding: EdgeInsets.all(12.w),
                                height: 56.h,
                                width: 56.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(203, 250, 252, 1),
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                child: Image.asset(
                                    "assets/icons/ic_default_profile.png"),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  profileController.userName!,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(16.w),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Мои заказы / My orders
                      GestureDetector(
                        onTap: () {
                          profileController.goMyOrdersPage();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          color: Colors.transparent,
                          height: 64.h,
                          // color: Colors.green,
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 50.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color.fromRGBO(241, 241, 241, 1),
                                ),
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.asset(
                                    'assets/icons/ic_order.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "my_orders".tr,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Мои заявки
                      GestureDetector(
                        onTap: () {
                          profileController.goMyWorksPage();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          color: Colors.transparent,
                          height: 64.h,
                          // color: Colors.green,
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 50.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color.fromRGBO(241, 241, 241, 1),
                                ),
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.asset(
                                    'assets/icons/ic_work.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "my_requests".tr,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Обратная связь
                      GestureDetector(
                        onTap: () {
                          showCall(context, controller);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          color: Colors.transparent,
                          height: 64.h,
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 50.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color.fromRGBO(241, 241, 241, 1),
                                ),
                                child: SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.asset(
                                    'assets/icons/ic_feedback.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  "feedback".tr,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  Column(
                    children: [
                      // settings / Настройки
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                "settings".tr,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // language
                      GestureDetector(
                        onTap: () {
                          showLanguage(
                              context, controller, controller.isUzbekSelected);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          color: Colors.transparent,
                          height: 64.h,
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 50.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color.fromRGBO(241, 241, 241, 1),
                                ),
                                child: Container(
                                  height: 24.w,
                                  width: 24.w,
                                  child: Image.asset(
                                    'assets/icons/ic_lang.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  "language".tr,
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // about / О приложении
                      GestureDetector(
                        onTap: () {
                          controller.goAboutPage();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          color: Colors.transparent,
                          height: 64.h,
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 50.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color.fromRGBO(241, 241, 241, 1),
                                ),
                                child: SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.asset(
                                    'assets/icons/ic_info.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  "about_app".tr,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // terms
                      GestureDetector(
                        onTap: () {
                          profileController.goTermsPage();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          color: Colors.transparent,
                          height: 64.h,
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 50.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color.fromRGBO(241, 241, 241, 1),
                                ),
                                child: SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.asset(
                                    'assets/icons/ic_offer.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  "policy".tr,
                                  maxLines: 1,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: const Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  // exit
                  GestureDetector(
                    onTap: () {
                      //logout
                      controller.logout();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      height: 48.h,
                      child: Center(
                        child: Text(
                          "logout".tr,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(224, 18, 18, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset("assets/images/im_profile.png"),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      // height: 56,
                      // width: 173,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "not_registered_info".tr,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "please_login".tr,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // login button
                    Container(
                      height: 48.h,
                      width: 173.w,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.buttonColor,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: 154, maxWidth: double.infinity),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          onPressed: () {
                            controller.goLoginPage();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                "auth".tr,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // settings / Настройки
                    Container(
                      // height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "settings".tr,
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // language
                    GestureDetector(
                      onTap: () {
                        showLanguage(
                            context, controller, controller.isUzbekSelected);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        color: Colors.transparent,
                        height: 64,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(241, 241, 241, 1),
                              ),
                              child: Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  'assets/icons/ic_lang.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "language".tr,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // about app
                    GestureDetector(
                      onTap: () {
                        controller.goAboutPage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        color: Colors.transparent,
                        height: 64,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(241, 241, 241, 1),
                              ),
                              child: Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  'assets/icons/ic_info.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "about_app".tr,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // terms
                    GestureDetector(
                      onTap: () {
                        profileController.goTermsPage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        color: Colors.transparent,
                        height: 64,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(241, 241, 241, 1),
                              ),
                              child: Container(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  'assets/icons/ic_offer.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "policy".tr,
                                maxLines: 1,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
