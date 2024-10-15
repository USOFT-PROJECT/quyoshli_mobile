import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/main_subpages/favourite_controller.dart';
import 'package:quyoshli/pages/main_subpages/favourite_shimer_page.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';

import '../../widgets/card_widget.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final controller = Get.find<FavouriteController>();

  @override
  void initState() {
    controller.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "favourites".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
              fontSize: 20.sp,
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w, bottom: 32.h),
          child: controller.isLoading
              ? FavouriteShimmerPage()
              : controller.products.isNotEmpty
                  ? GridView.builder(
                      //shrinkWrap: true,
                      // Let GridView take only as much space as it needs
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 1 / 1.6,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller
                                .goToDetailsProduct(controller.products[index]);
                          },
                          child: FavCard(
                            product: controller.products[index],
                          ),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/dev/fav_no_fav_img.png",
                          height: 80.w,
                          width: 80.w,
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: 206.w,
                          child: Text(
                            "empty_info".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 296.h,
                          child: Text(
                            "feedback_fv".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF474747),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: 133.w,
                          child: CustomButtonWidget(
                            label: 'go_home'.tr,
                            onPress: () {
                              //Get.offAll(const HomePage());
                              Get.back();
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
