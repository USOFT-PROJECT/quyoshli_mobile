import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/payment/unsuccessfull_payment_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../../widgets/custom_button_widget.dart';
import '../home/home_page.dart';

class PaymentUnsuccessPage extends StatefulWidget {
  static const String id = "un_success_page";

  const PaymentUnsuccessPage({super.key});

  @override
  State<PaymentUnsuccessPage> createState() => _PamentUnsuccessPageState();
}

class _PamentUnsuccessPageState extends State<PaymentUnsuccessPage> {
  Future<void> launchUrls(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  final controller = Get.find<UnsuccessfullPaymentController>();

  @override
  void initState() {
    controller.getFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnsuccessfullPaymentController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            // color: Colors.green,
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 16.h),
            // width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 80.h),
                      Column(
                        children: [
                          SizedBox(
                            height: 80.w,
                            width: 80.w,
                            child: Image.asset(
                                "assets/icons/ic_payment_unsuccess.png"),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            "error".tr,
                            textScaler: TextScaler.linear(1),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          // const Text(
                          //   "",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontSize: 16, fontWeight: FontWeight.w400),
                          // ),
                          SizedBox(height: 40.h),
                          Container(
                            height: 48.h,
                            // width: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.buttonColor,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                await controller.launchUrls(
                                  "tel:${controller.feedback.phone}",
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_phone_payment.png',
                                      width: 20.w,
                                      height: 20.w,
                                    ),
                                    SizedBox(
                                      width: 16.w
                                    ),
                                    Expanded(
                                      child: Text(
                                        "call_center".tr,
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(0, 98, 102, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          Container(
                            height: 48.h,
                            // width: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.buttonColor,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                controller.launchUrls(
                                  "https://${controller.feedback.telegramSupport}",
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_payment_tg.png',
                                      width: 20.w,
                                      height: 20.w,
                                    ),
                                    SizedBox(
                                      width: 16.w
                                    ),
                                    Expanded(
                                      child: Text(
                                        "contact_tg".tr,
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(0, 98, 102, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: CustomButtonWidget(
                    label: "close".tr,
                    onPress: () {
                      // Get.to(const PaymentSuccessPage());
                      Get.offAll(
                        () => const HomePage(
                          initialPage: 2,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
