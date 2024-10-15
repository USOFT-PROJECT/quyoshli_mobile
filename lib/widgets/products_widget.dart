import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/models/main/products_model.dart';
import 'package:quyoshli/pages/subpage/main_controller.dart';

import '../core/app_colors.dart';
import '../pages/catalog/products_controller.dart';
import '../pages/main_subpages/all_product_page.dart';
import '../services/utils_service.dart';
import 'card_widget.dart';
import 'home_all_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
    required this.products,
  });

  final ProductList products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Text(
                products.title ?? "",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              HomeAllWidget(onPress: () {
                Get.to(() => AllProductsView(products: products));
              }),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        //famous products
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (products.products ?? [])
                .map(
                  (e) => CardWidget(
                    product: e,
                    productListId: e.id ?? 0,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class ItemOfProduct extends StatefulWidget {
  final Product product;
  final int productListId;

  const ItemOfProduct({
    super.key,
    required this.product,
    required this.productListId,
  });

  @override
  State<ItemOfProduct> createState() => _ItemOfProductState();
}

class _ItemOfProductState extends State<ItemOfProduct> {
  bool isSelected = false;
  late Product product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
    isSelected = product.isFavorite ?? false;
  }

  @override
  void didUpdateWidget(covariant ItemOfProduct oldWidget) {
    product = widget.product;
    isSelected = product.isFavorite ?? false;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double w = ((MediaQuery.of(context).size.width - 48) / 2);

    return GestureDetector(
      onTap: () {
        Get.find<MainController>().goToDetailsProduct(product);
      },
      child: Container(
        // color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image box
            Container(
              // color: Colors.green,
              width: w,
              height: w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Stack(
                  children: [
                    //image
                    CachedNetworkImage(
                      width: w,
                      height: w,
                      fit: BoxFit.cover,
                      imageUrl: product.poster ?? "",
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/dev/card_img.png",
                        fit: BoxFit.cover,
                      ),
                      placeholder: (context, url) => Container(),
                    ),

                    Column(
                      children: [
                        //saved icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //saved
                            GestureDetector(
                              onTap: () async {
                                bool? result =
                                    await Get.find<ProductsController>().storeFavourite(
                                  product.id!.toString(),
                                  isSelected,
                                );
                                if (result != null) {
                                  setState(() {
                                    isSelected = result;
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 8.h, right: 8.w),
                                child: Image.asset(
                                  isSelected
                                      ? "assets/icons/ic_saved.png"
                                      : "assets/icons/ic_unsaved.png",
                                  width: 24.w,
                                  height: 24.w,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),

                        //discount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8.w, bottom: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //discount

                                  Visibility(
                                    visible: product.priceDiscount != 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/ic_discount.png",
                                            width: 12.w,
                                            height: 12.w,
                                          ),
                                          SizedBox(width: 2.w),
                                          Text(
                                            '${Utils.productDiscountPercent(price: product.price, priceDiscount: product.priceDiscount)} %',
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  //hit
                                  if (product.isLeaderOfSales == true)
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        color: const Color(0xFF01A2A8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/icons/ic_hit.png",
                                            height: 12.w,
                                            width: 12.w,
                                          ),
                                          SizedBox(width: 2.w),
                                          Text(
                                            "hit".tr,
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),

            //title
            Text(
              product.name ?? "",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 8.h),

            //previous price
            Visibility(
              visible:
                  (product.priceDiscount ?? 0) > 0 && product.price != null,
              child: Text(
                product.price?.decimal.toString() ?? '',
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF777777),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),

            //currentPrice
            Text(
              '${((product.priceDiscount ?? 0) > 0 ? (product.priceDiscount ?? 0) : (product.price ?? 0)).decimal} ${'currency'.tr}',
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
