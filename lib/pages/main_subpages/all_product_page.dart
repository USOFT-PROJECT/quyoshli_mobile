import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/main_subpages/all_product_controller.dart';
import 'package:quyoshli/pages/main_subpages/favourite_shimer_page.dart';

import '../../models/main/products_model.dart';
import '../../widgets/products_widget.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key, required this.products});

  final ProductList products;

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  final controller = Get.find<AllProductController>();

  @override
  void initState() {
    controller.getProducts(widget.products.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProductController>(
      builder: (_controller) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            widget.products.title ?? "",
            textScaler: TextScaler.linear(1),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          child: controller.isLoading
              ? FavouriteShimmerPage()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    // mainAxisSpacing: 16.h,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    var product = controller.products[index];
                    return ItemOfProduct(
                      product: product,
                      productListId: product.id ?? 0,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
