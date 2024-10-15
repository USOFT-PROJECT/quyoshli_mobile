import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/brand_list_model.dart';
import 'package:quyoshli/pages/main_subpages/brand_products_contoller.dart';
import 'package:quyoshli/pages/main_subpages/favourite_shimer_page.dart';

import '../../widgets/card_widget.dart';

class BrandProductsPage extends StatefulWidget {
  const BrandProductsPage({super.key, required this.brandModel});

  final BrandModel brandModel;

  @override
  State<BrandProductsPage> createState() => _BrandProductsPageState();
}

class _BrandProductsPageState extends State<BrandProductsPage> {
  final controller = Get.find<BrandProductsController>();

  @override
  void initState() {
    controller.getProducts(widget.brandModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandProductsController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.brandModel.name ?? "",
            textScaler: TextScaler.linear(1),
          ),
        ),
        body: controller.isLoading
            ? FavouriteShimmerPage()
            : controller.products.isNotEmpty
                ? Container(
                    padding: EdgeInsets.only(
                        top: 16.h, left: 16.w, right: 16.w, bottom: 32.h),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 1 / 1.6,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          controller.goToDetailsProduct(
                              controller.products[index], index);
                        },
                        child: FavCard(
                          product: controller.products[index],
                        ),
                      ),
                    ),
                  )
                : buildEmptyProductMessage(),
      ),
    );
  }

  Widget buildEmptyProductMessage() {
    return Center(
      child: Container(
        height: 128.h,
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
            Text("empty_info_products".tr, textScaler: TextScaler.linear(1)),
          ],
        ),
      ),
    );
  }
}
