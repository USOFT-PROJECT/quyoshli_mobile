import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/products_controller.dart';
import 'package:quyoshli/services/log_service.dart';

void brandBottomSheet(
    BuildContext context, ProductsController controller) async {
  controller.isBrandBottomSheetOpen = true;
  controller.update();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return GetBuilder<ProductsController>(
        builder: (_) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                padding: EdgeInsets.only(top: 24.h),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(28.r),
                    topLeft: Radius.circular(28.r),
                  ),
                ),
                child: Wrap(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              "brand".tr,
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          MediaQuery(
                            data: const MediaQueryData(
                                textScaler: TextScaler.linear(1.0)),
                            child: RadioListTile<String>(
                              activeColor: const Color(0xFF01A2A8),
                              title: Text("all".tr),
                              value: controller.selectedBrandOption.name.isEmpty
                                  ? ""
                                  : controller.selectedBrandOption.name,
                              groupValue: "all".tr,
                              onChanged: (_) {
                                setModalState(() {
                                  controller.selectedBrandOption.id = 0;
                                  controller.selectedBrandOption.name =
                                      "all".tr;
                                });
                              },
                            ),
                          ),

                          ...controller.brands.map(
                            (brand) {
                              return MediaQuery(
                                data: const MediaQueryData(
                                    textScaler: TextScaler.linear(1.0)),
                                child: RadioListTile<String>(
                                  activeColor: const Color(0xFF01A2A8),
                                  title: Text(brand.name),
                                  value: brand.name,
                                  groupValue: brand.id != 0
                                      ? controller.selectedBrandOption.name
                                      : '',
                                  onChanged: (value) {
                                    setModalState(() {
                                      controller.selectedBrandOption.id =
                                          brand.id;
                                      controller.selectedBrandOption.name =
                                          brand.name;
                                    });
                                  },
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),

                    // buttons
                    Container(
                      height: 80.h,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color.fromRGBO(226, 226, 226, 1),
                            width: 1.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.products.clear();
                                controller.selectedBrandOption.id = 0;
                                controller.selectedBrandOption.name = '';
                                controller.update();

                                controller.apiProducts(
                                  controller.selectedSortOption.slug,
                                  0,
                                  controller.priceFromController.text
                                      .replaceAll(" ", ""),
                                  controller.priceToController.text
                                      .replaceAll(" ", ""),
                                );

                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "reset".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(0, 98, 102, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.products.clear();

                                controller.apiProducts(
                                  controller.selectedSortOption.slug,
                                  controller.selectedBrandOption.name !=
                                          'all'.tr
                                      ? controller.selectedBrandOption.id
                                      : 0,
                                  controller.priceFromController.text
                                      .replaceAll(" ", ""),
                                  controller.priceToController.text
                                      .replaceAll(" ", ""),
                                );
                                controller.brandOptionSelected = true;

                                controller.update();
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(3, 55, 57, 1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "apply".tr,
                                    textScaler: TextScaler.linear(1),
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
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );

  controller.isBrandBottomSheetOpen = false;
  controller.update();
}
