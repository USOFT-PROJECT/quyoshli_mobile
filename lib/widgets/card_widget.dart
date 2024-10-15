import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/models/main/favourite_products_model.dart';
import 'package:quyoshli/models/main/products_model.dart';
import 'package:quyoshli/pages/login/login_page.dart';
import 'package:quyoshli/pages/main_subpages/favourite_controller.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/utils_service.dart';

import '../pages/subpage/main_controller.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CardWidget extends StatefulWidget {
  final Product product;
  final int productListId;

  const CardWidget({
    super.key,
    required this.product,
    required this.productListId,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isSelected = false;
  late Product product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
    isSelected = product.isFavorite ?? false;
  }

  @override
  void didUpdateWidget(covariant CardWidget oldWidget) {
    product = widget.product;
    isSelected = product.isFavorite ?? false;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double w = 148.w;

    return GestureDetector(
      onTap: () {
        Get.find<MainController>().goToDetailsProduct(product);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image box
            SizedBox(
              width: w,
              height: w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
                                Utils.vibrate();
                                bool? result = await Get.find<MainController>()
                                    .storeFavourite(
                                  product.id!.toString(),
                                  isSelected,
                                );
                                if (result != null) {
                                  setState(() {
                                    isSelected = result;
                                  });
                                }
                                widget.product.isFavorite = result;
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 8.h, right: 8.w),
                                  child: Image.asset(
                                    isSelected
                                        ? "assets/icons/ic_saved.png"
                                        : "assets/icons/ic_unsaved.png",
                                    width: 24.w,
                                    height: 24.w,
                                  )),
                            )
                          ],
                        ),
                        const Spacer(),

                        //discount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8, bottom: 8),
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
                                            width: 12,
                                            height: 12,
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

                                  Visibility(
                                    visible: product.isLeaderOfSales == true,
                                    child: Container(
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
                                    ),
                                  ),
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
            SizedBox(
              width: w,
              child: Text(
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
            ),
            SizedBox(height: 8.h),

            //previous price
            Visibility(
              visible: (product.priceDiscount ?? 0) > 0,
              child: Text(
                product.price?.decimal ?? '',
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

class FavCard extends StatefulWidget {
  const FavCard({super.key, required this.product});

  final FavouriteProductModel product;

  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  late FavouriteProductModel productModel;

  @override
  void initState() {
    productModel = widget.product;
    super.initState();
    isSelected = productModel.isFavorite ?? false;
  }

  bool isSelected = false;

  @override
  void didUpdateWidget(covariant FavCard oldWidget) {
    productModel = widget.product;
    isSelected = productModel.isFavorite ?? false;
    super.didUpdateWidget(oldWidget);
  }

  Future<bool?> storeFavourite(String productId, bool isSelected) async {
    if (DBService.getRegistered()) {
      try {
        isSelected
            ? await Network.DEL("/api/products/$productId/favorites")
            : await Network.GET("/api/products/$productId/favorites", {});

        return !isSelected;
      } catch (e) {
        LogService.e(e.toString());
      }
      return null;
    } else {
      Get.to(() => const LoginPage());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // solar panel image
        Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: ((MediaQuery.of(context).size.width - 48) / 2).w,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: productModel.poster ?? "",
                    placeholder: (context, urls) => Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    errorWidget: (context, urls, error) =>
                        const Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      //saved icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Utils.vibrate();
                              bool? result = await storeFavourite(
                                  productModel.id.toString(), isSelected);
                              if (result != null) {
                                setState(() {
                                  isSelected = result;
                                });
                                if (!isSelected) {
                                  Get.find<FavouriteController>()
                                      .remove(productModel);
                                }
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
                                if (productModel.priceDiscount != 0)
                                  Container(
                                    alignment: Alignment.center,
                                    width: 50.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 4.w),
                                        Image.asset(
                                          "assets/icons/ic_discount.png",
                                          width: 12.w,
                                          height: 12.w,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "${productModel.discountPercent ?? ""}%",
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 4.h),
                                //hit
                                if (productModel.isLeaderOfSales == true)
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: const Color(0xFF01A2A8),
                                    ),
                                    child: Row(
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
          ],
        ),

        SizedBox(height: 8.h),

        Container(
          width: double.infinity,
          // color: Colors.green,
          child: Text(
            productModel.name ?? "",
            textScaler: TextScaler.linear(1),
            maxLines: 2,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        SizedBox(height: 2.h),

        Container(
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (productModel.priceDiscount ?? 0) > 0
                  ? Text(
                      productModel.price?.decimal ?? '',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFF777777),
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Text(
                      "",
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFF777777),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

              //currentPrice
              Text(
                '${((productModel.priceDiscount ?? 0) > 0 ? (productModel.priceDiscount ?? 0) : (productModel.price ?? 0)).decimal} ${'currency'.tr}',
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    );
  }
}
