import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/cart/paymet_response_model.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/subpage/cart_controller.dart';
import 'package:quyoshli/services/log_service.dart';

import '../../core/app_colors.dart';
import '../../core/mixin/launch_mixin.dart';
import '../../widgets/custom_button_widget.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key, required this.payment});

  final PaymentResponseModel payment;

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage>
    with LaunchMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle your logic here (e.g., show a dialog)
        LogService.i("Handle your logic");
        Get.offAll(const HomePage(
          initialPage: 2,
        ));
        return true; // Return true to allow the back button, or false to prevent it
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: (MediaQuery.of(context).size.width).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 80.h),
                      SizedBox(
                        height: 293.h,

                        width: 296.w,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.h,
                              width: 80.w,
                              child: Image.asset("assets/icons/ic_check.png"),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              "success_registration".tr,
                              textScaler: TextScaler.linear(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "${"order_number".tr} ${widget.payment.data?.id}",
                              textScaler: TextScaler.linear(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 40.h),
                            if (widget.payment.data?.contractUrl != null)
                              Container(
                                height: 48.h,
                                // width: 125,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.buttonColor,
                                    )),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (widget.payment.data?.contractUrl !=
                                        null) {
                                      launchInBrowser(
                                          widget.payment.data?.contractUrl);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text(
                                      "download_contract".tr,
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(0, 98, 102, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  child: CustomButtonWidget(
                    label: "close".tr,
                    onPress: () {
                      // Get.to(const PaymentSuccessPage());
                      Get.find<CartController>().removeProducts();
                      Get.offAll(() => const HomePage(
                            initialPage: 2,
                          ));
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
