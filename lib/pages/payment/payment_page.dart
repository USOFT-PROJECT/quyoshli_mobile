import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/payment/payment_controller.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';

class PhysicalPaymentPage extends StatefulWidget {
  const PhysicalPaymentPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<PhysicalPaymentPage> createState() => _PhysicalPaymentPageState();
}

class _PhysicalPaymentPageState extends State<PhysicalPaymentPage> {
  final controller = Get.find<PaymentController>();

  @override
  void initState() {
    controller.apiLoadPaymentSystem();
    LogService.w(controller.paymentTypes.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "payment".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w, bottom: 32.h),
          child: controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "payment_method".tr,
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(4.w),
                          height: 56.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: const Color.fromRGBO(233, 233, 233, 1),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.choosePaymentType(true);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: controller.isPaymentSystem
                                          ? Colors.white
                                          : const Color.fromRGBO(
                                              233, 233, 233, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'cost'.tr,
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (controller
                                      .paymentSystem!.paymentTypes!.length >
                                  1)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.choosePaymentType(false);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        color: !controller.isPaymentSystem
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                233, 233, 233, 1),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'cash'.tr,
                                                textScaler: TextScaler.linear(1),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    if (controller.isPaymentSystem)
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  controller.paymentTypes.isNotEmpty
                                      ? controller.paymentTypes[0].title ?? ''
                                      : '',

                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Expanded(
                              child: GridView.builder(
                                itemCount: controller.paymentTypes.isNotEmpty
                                    ? controller.paymentTypes[0].systems?.length
                                    : 0,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                  childAspectRatio: 2 / 1,
                                ),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    controller.choosePaymentSystem(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          color:
                                              controller.paymentIndex == index
                                                  ? const Color(0xFF01A2A8)
                                                  : const Color(0xFF777777),
                                          width: 1),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: controller.paymentTypes[0]
                                              .systems?[index].logo ??
                                          '',
                                      errorWidget: (context, urls, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    if (!controller.isPaymentSystem)
                      Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/ic_how_to_use.png",
                                height: 24.w,
                                width: 24.w,
                              ),
                              SizedBox(
                                width: 16.w
                              ),
                              Expanded(
                                child: Text(
                                  controller.paymentTypes[1].systems?[0]
                                          .description ??
                                      '',
                                  textScaler: TextScaler.linear(1),
                                  maxLines: null,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        label: (controller.isPaymentSystem ?'pay':'draw_contract').tr,
                        onPress: () {
                          controller.pay(widget.data);
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
