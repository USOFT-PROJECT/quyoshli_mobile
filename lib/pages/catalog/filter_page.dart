import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/products_controller.dart';

import '../../services/log_service.dart';
import '../../services/utils_service.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final controller = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "filter".tr,
          textScaler: TextScaler.linear(1),
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "sorting".tr,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                Wrap(
                  children: controller.sort_by.map((option) {
                    return ItemOfFilter(
                      brand: option.name,
                      isSelected: controller.selectedSortOption.name == option.name,
                      onSelected: (bool selected) {
                        setState(() {
                          controller.selectedSortOption.name = option.name;
                          controller.selectedSortOption.slug = option.slug;
                        });
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 24.h),

                // Бренд
                Row(
                  children: [
                    Text(
                      "brand".tr,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Wrap(
                  children: [
                    ItemOfBrand(
                      brand: "all".tr,
                      isSelected: controller.selectedBrandOption.name == "all".tr,
                      onSelected: (bool selected) {
                        setState(() {
                          controller.selectedBrandOption.id = 0;
                          controller.selectedBrandOption.name = "all".tr;
                        });
                      },
                    ),

                    ...controller.brands.map((brand) {
                      return ItemOfBrand(
                        brand: brand.name,
                        isSelected: controller.selectedBrandOption.name == brand.name,
                        onSelected: (bool selected) {
                          setState(() {
                            controller.selectedBrandOption.id = brand.id;
                            controller.selectedBrandOption.name = brand.name;
                          });
                        },
                      );
                    })
                  ],
                ),

                SizedBox(height: 24.h),

                // Цена
                Row(
                  children: [
                    Text(
                      "price".tr,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 56.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 12.w, right: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Color.fromRGBO(241, 241, 241, 1),
                          ),
                          child: MediaQuery(
                            data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
                            child: TextField(
                              controller: controller.priceFromController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                TextInputFormatter.withFunction((oldValue, newValue) {
                                  String newText = newValue.text.replaceAll(' ', '');
                                  String formattedText = Utils.putSpace(newText);
                                  return TextEditingValue(
                                    text: formattedText,
                                    selection: TextSelection.collapsed(offset: formattedText.length),
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
                                top: 16.h, bottom: 16.h, left: 12.w, right: 4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Color.fromRGBO(241, 241, 241, 1),
                            ),
                            child: MediaQuery(
                              data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
                              child: TextField(
                                controller: controller.priceToController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    String newText = newValue.text.replaceAll(' ', '');
                                    String formattedText = Utils.putSpace(newText);
                                    return TextEditingValue(
                                      text: formattedText,
                                      selection: TextSelection.collapsed(offset: formattedText.length),
                                    );
                                  }),
                                ],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: "price_to".tr,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(226, 226, 226, 1),
              width: 1,
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
                  controller.selectedBrandOption.id = 0;
                  controller.selectedBrandOption.name = '';
                  controller.priceFromController.clear();
                  controller.priceToController.clear();
                  controller.update();

                  controller.apiProducts('', 0, '', '');

                  Get.back();
                },
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color.fromRGBO(119, 119, 119, 1),
                    ),
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
                  controller.update();

                  controller.apiProducts(
                    controller.selectedSortOption.slug,
                    controller.selectedBrandOption.id,
                    controller.priceFromController.text.replaceAll(" ", ""),
                    controller.priceToController.text.replaceAll(" ", ""),
                  );
                  LogService.w(controller.selectedSortOption.slug);
                  Get.back();
                },
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: const Color.fromRGBO(3, 55, 57, 1),
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
      ),
    );
  }
}

// item of brand
class ItemOfBrand extends StatelessWidget {
  final String brand;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ItemOfBrand({
    super.key,
    required this.brand,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),

        child: ChoiceChip(
          showCheckmark: false,
          label: Text(brand),
          selected: isSelected,
          onSelected: onSelected,
          selectedColor: const Color.fromRGBO(203, 250, 252, 1),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected
                  ? const Color.fromRGBO(0, 98, 102, 1)
                  : const Color.fromRGBO(119, 119, 119, 1),
            ),
            borderRadius: BorderRadius.circular(10.0.r),
          ),
        ),
      ),
    );
  }
}

// item of filter
class ItemOfFilter extends StatelessWidget {
  final String brand;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ItemOfFilter({
    super.key,
    required this.brand,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
        child: ChoiceChip(
          showCheckmark: false,
          label: Text(brand),
          selected: isSelected,
          onSelected: onSelected,
          selectedColor: const Color.fromRGBO(203, 250, 252, 1),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected
                  ? const Color.fromRGBO(0, 98, 102, 1)
                  : const Color.fromRGBO(119, 119, 119, 1),
            ),
            borderRadius: BorderRadius.circular(10.0.r),
          ),
        ),
      ),
    );
  }
}
