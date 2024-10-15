import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/products_controller.dart';

import '../../services/log_service.dart';

void sortingBottomSheet(
    ProductsController controller, BuildContext context) async {
  controller.isSortingBottomSheetOpen = true;
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
                      width: (MediaQuery.of(context).size.width).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              "sorting".tr,
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          ...controller.sort_by.map((option) {
                            return MediaQuery(
                              data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
                              child: RadioListTile<String>(
                                activeColor: const Color(0xFF01A2A8),
                                title: Text(option.name),
                                value: option.name,
                                groupValue: option.slug.isNotEmpty
                                    ? controller.selectedSortOption.name
                                    : '',
                                onChanged: (value) {
                                  setModalState(() {
                                    controller.selectedSortOption.name =
                                        option.name;
                                    controller.selectedSortOption.slug =
                                        option.slug;
                                  });
                                },
                              ),
                            );
                          }),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),

                    // buttons
                    Container(
                      height: 80.h,
                      padding: EdgeInsets.all(16.w),
                      margin: EdgeInsets.only(bottom: 16.h),
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
                                controller.selectedSortOption.slug = '';
                                controller.selectedSortOption.name = '';
                                controller.update();

                                controller.apiProducts(
                                  '',
                                  controller.selectedBrandOption.id,
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
                                    color: const Color.fromRGBO(119, 119, 119, 1),
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
                                controller.sortOptionSelected = true;
                                controller.update();

                                controller.apiProducts(
                                  controller.selectedSortOption.slug,
                                  controller.selectedBrandOption.id,
                                  controller.priceFromController.text
                                      .replaceAll(" ", ""),
                                  controller.priceToController.text
                                      .replaceAll(" ", ""),
                                );
                                LogService.w(
                                    controller.selectedSortOption.slug);
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

  controller.isSortingBottomSheetOpen =
      false; // Update the arrow state when the sheet closes
  controller.update();
}
