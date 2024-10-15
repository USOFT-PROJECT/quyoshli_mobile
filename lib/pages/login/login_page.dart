import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/login/login_controller.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';

import '../../core/app_colors.dart';
import '../terms/terms_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = "login_page";
  final bool isLoginFromHome;

  const LoginPage({super.key, this.isLoginFromHome = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    Utils.phoneNumberMask.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              "auth".tr,
              textScaler: TextScaler.linear(1),
              style: TextStyle(fontSize: 20.sp),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 19.h),
                    height: 108.w,
                    width: 108.w,
                    child: Image.asset('assets/images/ic_quyoshli.png'),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Quyoshli",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "enter_number".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF454745),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(241, 241, 241, 1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MediaQuery(
                      data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
                      child: TextField(
                        autofocus: true,
                        inputFormatters: [Utils.phoneNumberMask],
                        controller: controller.phoneController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 12.sp),
                        decoration: InputDecoration(
                            label: Text(
                              "phone".tr,
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.textFieldLabelColor,
                              ),
                            ),
                            border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButtonWidget(
                        label: "login".tr,
                        onPress: () {
                          controller.login(widget.isLoginFromHome);
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const TermsPage());
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50.h),
                      width: 300.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // if (DBService.getLanguage() == 'uz')
                          Column(
                            children: [
                              Text(
                                "logging_by".tr,
                                textScaler: TextScaler.linear(1),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              Text(
                                "agree_policy".tr,
                                textScaler: TextScaler.linear(1),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 135, 0, 1),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
