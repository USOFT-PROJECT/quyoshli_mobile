import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quyoshli/main.dart';
import 'package:quyoshli/pages/otpsms/otpsms_controller.dart';

import '../../services/db_service.dart';

class OtpSmsPage extends StatefulWidget {
  final String? phoneNumber;
  final bool isLoginFromHome;
  static const String id = "otpsms_page";
  final Widget? returnPage;

  const OtpSmsPage(
      {super.key,
      this.phoneNumber,
      this.returnPage,
      this.isLoginFromHome = false});

  @override
  State<OtpSmsPage> createState() => _OtpSmsPageState();
}

class _OtpSmsPageState extends State<OtpSmsPage> {
  @override
  void initState() {
    Get.find<OtpSmsController>().errorController =
        StreamController<ErrorAnimationType>();
    super.initState();
    Get.find<OtpSmsController>().waitForOneMinute();
  }

  @override
  void dispose() {
    Get.find<OtpSmsController>().errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "auth".tr,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: GetBuilder<OtpSmsController>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (DBService.getLanguage() == 'ru')
                    Container(
                      padding: EdgeInsets.all(40.w),
                      child: RichText(
                        text: TextSpan(
                          text: "to_number".tr,
                          children: [
                            TextSpan(
                              text: controller.obscure(widget.phoneNumber ?? ""),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                            TextSpan(
                              text: "send_sms".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (DBService.getLanguage() == 'uz')
                    Container(
                      padding: EdgeInsets.all(40.w),
                      child: RichText(
                        text: TextSpan(
                          // text: "to_number".tr,
                          text: controller.obscure(widget.phoneNumber ?? ""),
                          children: [
                            TextSpan(
                              text: "to_number".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.sp,
                              ),
                            ),
                            TextSpan(
                              text: "send_sms".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: PinCodeTextField(
                      autoFocus: true,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 5,
                      obscureText: false,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10.r),
                        fieldHeight: 56.h,
                        fieldWidth: 48.w,
                        inactiveFillColor:
                            const Color.fromRGBO(231, 234, 231, 1),
                        inactiveColor: const Color.fromRGBO(231, 234, 231, 1),
                        activeFillColor: const Color.fromRGBO(231, 234, 231, 1),
                        activeColor: const Color.fromRGBO(231, 234, 231, 1),
                        selectedColor: Colors.black,
                        selectedFillColor:
                            const Color.fromRGBO(231, 234, 231, 1),
                        errorBorderColor: Colors.red,
                      ),

                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: controller.errorController,
                      controller: controller.smsEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        controller.verify(
                            widget.phoneNumber!, widget.isLoginFromHome);
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        controller.otpCode = value;
                        debugPrint(value);
                      },
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.resend(widget.phoneNumber!);
                    },
                    child: controller.seconds == 60
                        ? Text(
                            "resend".tr,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color.fromRGBO(0, 98, 102, 1),
                            ),
                          )
                        : Text(
                            textScaleFactor: 1.0,
                            "${"resend".tr} ${controller.seconds}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
