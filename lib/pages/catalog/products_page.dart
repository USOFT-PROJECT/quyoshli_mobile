import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/catalog/prodcucts_shimmer.dart';
import 'package:quyoshli/pages/catalog/products_controller.dart';
import 'package:quyoshli/widgets/catalog/bottom_sheet_brand.dart';
import 'package:quyoshli/widgets/catalog/item_of_product.dart';

import '../../widgets/catalog/bottom_sheet_price.dart';
import '../../widgets/catalog/bottom_sheet_sorting.dart';

class ProductsPage extends StatefulWidget {
  final String? title;
  final int? id;
  final int? categoryId;

  const ProductsPage({super.key, this.title, this.id, this.categoryId});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    controller.clear();
    controller.title = widget.title!;
    controller.id = widget.id!;
    controller.categoryId = widget.categoryId!;

    controller.apiFilters(controller.categoryId);

    controller.scrollController.addListener(controller.scrollListener);

    controller.apiProducts(
      controller.selectedSortOption.slug,
      controller.selectedBrandOption.id,
      controller.priceFromController.text,
      controller.priceToController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Text(
            controller.title,
            textScaler: TextScaler.linear(1),
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                controller.goToSearchPage();
              },
              child: const Icon(Icons.search),
            ),
            SizedBox(width: 16.w),
          ],
        ),
        body: controller.isLoading
            ? ProductsShimmer()
            : Container(
                padding: EdgeInsets.only(top: 8.h, right: 16.w, left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Always show filter options if filters are applied or products exist
                    if (!controller.areFiltersApplied() ||
                        controller.productsInitiallyAvailable)
                      buildFilterOptions(controller),

                    SizedBox(height: 24.h),

                    Expanded(
                      child: controller.products.isNotEmpty
                          ? buildProductGrid(controller)
                          : buildEmptyProductMessage(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // Function to build the grid of products
  Widget buildProductGrid(ProductsController controller) {
    return GridView.builder(
      controller: controller.scrollController,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1 / 1.6,
      ),
      itemCount: controller.products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () =>
              controller.goToDetailsProduct(controller.products[index], index),
          child: ItemOfProduct(
              product: controller.products[index], productListId: index),
        );
      },
    );
  }

  Widget buildFilterOptions(ProductsController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Filter icon
          GestureDetector(
            onTap: () => controller.goToFilterPage(),
            child: Image.asset(
              "assets/icons/ic_filter.png",
              height: 24.w,
              width: 24.w,
            ),
          ),
          SizedBox(width: 16.w),

          // Sorting filter
          GestureDetector(
            onTap: () => sortingBottomSheet(controller, Get.context!),
            child: buildFilterOption(
              text: controller.selectedSortOption.slug.isEmpty || !controller.sortOptionSelected
                  ? "default_sort".tr
                  : controller.selectedSortOption.name,
              isSelected: controller.selectedSortOption.slug.isNotEmpty && controller.sortOptionSelected,
            ),
          ),
          SizedBox(width: 8.w),

          // Brand filter
          GestureDetector(
            onTap: () => brandBottomSheet(Get.context!, controller),
            child: buildFilterOption(
              text: controller.selectedBrandOption.id == 0 || !controller.brandOptionSelected
                  ? "brand".tr
                  : controller.selectedBrandOption.name,
              isSelected: controller.selectedBrandOption.id != 0 && controller.brandOptionSelected,
            ),
          ),
          const SizedBox(width: 8),

          // Price filter
          GestureDetector(
            onTap: () => priceBottomSheet(Get.context!, controller),
            child: buildFilterOption(
              text: "price".tr,
              isSelected: (controller.priceFromController.text.isNotEmpty ||
                  controller.priceToController.text.isNotEmpty) && controller.priceOptionSelected,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterOption({required String text, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 32.h,
      decoration: BoxDecoration(
        color:
            isSelected ? const Color.fromRGBO(203, 250, 252, 1) : Colors.white,
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(
          color: isSelected
              ? const Color.fromRGBO(0, 98, 102, 1)
              : const Color.fromRGBO(119, 119, 119, 1),
        ),
      ),
      child: Row(
        children: [
          Text(
            text,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(71, 71, 71, 1),
            ),
          ),
          SizedBox(width: 8.w),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget buildEmptyProductMessage() {
    return Center(
      child: Container(
        height: 140.h,
        width: 296.w,
        child: Column(
          children: [
            Container(
              height: 80.w,
              width: 80.w,
              child: Image.asset(
                "assets/icons/ic_catalog.png",
                color: const Color.fromRGBO(226, 226, 226, 1),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24.h),
            Text("empty_info_products".tr, textScaler: TextScaler.linear(1),),
          ],
        ),
      ),
    );
  }
}
