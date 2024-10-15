import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/models/catalog/filter_model.dart';
import 'package:quyoshli/pages/catalog/products_controller.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:quyoshli/services/utils_service.dart';

void priceBottomSheet(
    BuildContext context, ProductsController productsController) async {
  productsController.isPriceBottomSheetOpen = true;
  productsController.update();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return GetBuilder<ProductsController>(
        builder: (_) {
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
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
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
                            "price".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        Container(
                          height: 56.h,
                          margin: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 16.h,
                                      bottom: 16.h,
                                      left: 12.w,
                                      right: 4.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Color.fromRGBO(241, 241, 241, 1),
                                  ),
                                  child: MediaQuery(
                                    data: const MediaQueryData(
                                        textScaler: TextScaler.linear(1.0)),
                                    child: TextField(
                                      controller: productsController
                                          .priceFromController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          String newText =
                                              newValue.text.replaceAll(' ', '');
                                          String formattedText =
                                              Utils.putSpace(newText);
                                          return TextEditingValue(
                                            text: formattedText,
                                            selection: TextSelection.collapsed(
                                                offset: formattedText.length),
                                          );
                                        }),
                                      ],
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "price_from".tr,
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 16.h,
                                        bottom: 16.h,
                                        left: 12.w,
                                        right: 4.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Color.fromRGBO(241, 241, 241, 1),
                                    ),
                                    child: MediaQuery(
                                      data: const MediaQueryData(
                                          textScaler: TextScaler.linear(1.0)),
                                      child: TextField(
                                        controller: productsController
                                            .priceToController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            String newText = newValue.text
                                                .replaceAll(' ', '');
                                            String formattedText =
                                                Utils.putSpace(newText);
                                            return TextEditingValue(
                                              text: formattedText,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset:
                                                          formattedText.length),
                                            );
                                          }),
                                        ],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "price_to".tr,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (text) {
                                          // Update controller manually with raw numeric value without spaces
                                          productsController.priceToController
                                              .text = text.replaceAll('+', '');
                                        },
                                      ),
                                    )),
                              ),
                            ],
                          ),
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
                              productsController.products.clear();
                              productsController.apiProducts(
                                  productsController.selectedSortOption.slug,
                                  productsController.selectedBrandOption.id,
                                  "",
                                  "");
                              productsController.priceFromController.clear();
                              productsController.priceToController.clear();
                              productsController.back();
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
                              productsController.priceOptionSelected = true;

                              productsController.products.clear();
                              productsController.update();

                              productsController.apiProducts(
                                productsController.selectedSortOption.slug,
                                productsController.selectedBrandOption.id,
                                productsController.priceFromController.text
                                    .replaceAll(" ", ""),
                                productsController.priceToController.text
                                    .replaceAll(" ", ""),
                              );
                              productsController.back();
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
            ),
          );
        },
      );
    },
  );

  productsController.isPriceBottomSheetOpen = false;
  productsController.update();
}
