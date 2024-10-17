import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/core/ext/string_ext.dart';
import 'package:quyoshli/core/mixin/launch_mixin.dart';
import 'package:quyoshli/pages/catalog/product_detail_controller.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/main_subpages/favourite_controller.dart';
import 'package:quyoshli/services/utils_service.dart';

import '../../core/app_colors.dart';
import '../../models/catalog/product_show_model.dart';
import '../../widgets/expandable-page-view/expandable_page_view.dart';

class ProductDetailsPage extends StatefulWidget {
  final ShowProduct? product;

  const ProductDetailsPage({super.key, this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with LaunchMixin {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = Get.find<FavouriteController>()
        .products
        .where((x) => x.id == widget.product?.id)
        .isNotEmpty;
    super.initState();
    Get.find<ProductDetailController>().product = widget.product;
    Get.find<ProductDetailController>()
        .updateCount(widget.product!.inCart ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
        builder: (controller) => widget.product != null
            ? PopScope(
                onPopInvokedWithResult: (didPop, result) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    // Check if we are still on this page before calling Get.back()
                    if (Get.isOverlaysOpen) {
                      Get.back(result: controller.product?.isFavorite);
                    }
                  });
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          Get.back(result: controller.product?.isFavorite);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    actions: [
                      IconButton(
                        icon: Icon(
                          controller.product?.isFavorite == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.product?.isFavorite == true
                              ? const Color(0xffD6191D)
                              : null,
                        ),
                        onPressed: () {
                          Utils.vibrate();
                          controller.storeFavourite();
                        },
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // image
                              Stack(
                                children: [
                                  ExpandablePageView.builder(
                                      controller: PageController(
                                          initialPage:
                                              controller.selectedImage),
                                      itemCount:
                                          controller.product?.screens?.length ??
                                              0,
                                      onPageChanged: (index) {
                                        controller.changePhoto(index);
                                      },
                                      clipBehavior: Clip.none,
                                      itemBuilder: (_, index) => AspectRatio(
                                            aspectRatio: 1,
                                            child: CachedNetworkImage(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width
                                                  .w,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  '${controller.product!.screens?[index].path}',
                                              placeholder: (context, urls) =>
                                                  Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, urls, error) =>
                                                      Container(
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          )),
                                  Visibility(
                                    visible:
                                        controller.product!.isLeaderOfSales ==
                                            true,
                                    child: Positioned(
                                      left: 16.w,
                                      bottom: 16.w,
                                      child: Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: const Color(0xFF01A2A8),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/ic_hit.png",
                                              width: 16.w,
                                              height: 16.w,
                                            ),
                                            const SizedBox(width: 4),
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
                                  ),
                                  Positioned(
                                    right: 16,
                                    bottom: 16,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: List.generate(
                                          controller.product!.screens?.length ??
                                              0,
                                          (index) {
                                            return Container(
                                              height: 8,
                                              width: 8,
                                              margin: EdgeInsets.only(
                                                  right: index ==
                                                          (controller
                                                                      .product!
                                                                      .screens
                                                                      ?.length ??
                                                                  0) -
                                                              1
                                                      ? 0
                                                      : 4),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                              .selectedImage ==
                                                          index
                                                      ? const Color(0xff01A2A8)
                                                      : const Color(0xffE2E2E2),
                                                  shape: BoxShape.circle),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              Container(
                                padding: EdgeInsets.only(
                                    top: 16.h,
                                    left: 16.w,
                                    right: 16.w,
                                    bottom: 48.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.product!.name}",
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 24.h),
                                        Visibility(
                                          visible: Utils.productHasDiscount(
                                              controller
                                                  .product!.priceDiscount),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.h),
                                            child: SizedBox(
                                              height: 24.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.product!.price
                                                            ?.decimal ??
                                                        "",
                                                    textScaler:
                                                        TextScaler.linear(1),
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Color.fromRGBO(
                                                          119, 119, 119, 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),

                                                  //discountView
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.w),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              214, 25, 29, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.r),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/ic_sale.png",
                                                          height: 16.w,
                                                          width: 16.w,
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        Text(
                                                          "-${Utils.productDiscountPercent(
                                                            price: controller
                                                                .product!.price,
                                                            priceDiscount:
                                                                controller
                                                                    .product!
                                                                    .priceDiscount,
                                                          )}%",
                                                          textScaler: TextScaler.linear(1),
                                                          style:
                                                          TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${controller.product!.priceDiscount != 0 ? controller.product!.priceDiscount?.decimal : controller.product!.price?.decimal} ${'currency'.tr}',
                                              textAlign: TextAlign.start,
                                              textScaler: TextScaler.linear(1),
                                              style: TextStyle(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    0, 98, 102, 1),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.h),
                                              child: Text(
                                                'with_vat'.tr,
                                                textScaler: TextScaler.linear(1),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Color.fromRGBO(
                                                      71, 71, 71, 1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          '${controller.product!.priceDiscount != 0 ? controller.product!.priceDiscountUsd?.decimal.toString() : controller.product!.priceUsd?.decimal.toString()} у.е.',
                                          textAlign: TextAlign.start,
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromRGBO(71, 71, 71, 1),
                                          ),
                                        ),
                                        SizedBox(height: 24.h),
                                        Row(
                                          children: [
                                            Text.rich(
                                              textScaler: TextScaler.linear(1),
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'in_stock'.tr,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        '${controller.product!.count?.decimal ?? 0} ${'count_symbol'.tr}',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            0, 168, 0, 1)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24.h),

                                    // shortDescription
                                    Text(
                                      controller.product!.shortDescription.toString(),
                                      textAlign: TextAlign.justify,
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    ),

                                    SizedBox(height: 24.h),

                                    // Description Button
                                    GestureDetector(
                                      onTap: (){
                                        controller.goDescriptionPage(controller.product!.description!);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Color.fromRGBO(119, 119, 119, 1)
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "full_description".tr,
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(0, 98, 102, 1)
                                            ),
                                           ),
                                        ),
                                      ),
                                    ),

                                    if (controller.product!.characteristics!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "technical_info".tr,
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: (MediaQuery.of(context).size.width /2).w,
                                                child: Text(
                                                  "${controller.product!.characteristics?[0].name}",
                                                  textScaler: TextScaler.linear(1),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                controller
                                                        .product!
                                                        .characteristics?[0]
                                                        .pivot
                                                        ?.value
                                                        ?.decimalStr ??
                                                    '',
                                                textScaler: TextScaler.linear(1),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: List.generate(
                                              controller.product!
                                                  .characteristics!.length,
                                              (index) {
                                                return Container(
                                                  color: Colors.transparent,
                                                  child: itemOfCharacter(
                                                      controller.product!
                                                              .characteristics![
                                                          index]),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Visibility(
                                            visible:
                                                controller.product!.dataSheet !=
                                                    null,
                                            child: MaterialButton(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              elevation: 0,
                                              height: 40.h,
                                              onPressed: () {
                                                launchInBrowser(controller
                                                    .product!.dataSheet!);
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                side: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/ic_document.png",
                                                    height: 20.w,
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    "download_datasheet".tr,
                                                    textScaler: TextScaler.linear(1),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromRGBO(
                                                            0, 98, 102, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // cost and pay button
                      SafeArea(
                        top: false,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: 80.h,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color.fromRGBO(226, 226, 226, 1),
                                width: 1.w,
                              ),
                            ),
                            // color: Colors.green,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: controller.count != 0 &&
                                          controller.product?.priceDiscount !=
                                              0,
                                      replacement: Text(
                                        controller.product?.priceDiscount != 0
                                            ? controller
                                                    .product?.price?.decimal ??
                                                ""
                                            : "",
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1),
                                        ),
                                      ),
                                      child: Text(
                                        "${"in_cart".tr} ${controller.count} ${"count_symbol".tr}",
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Utils.putSpace("${controller.product?.priceDiscount != 0 ? controller.product?.priceDiscount : controller.product?.price}")} ${'currency'.tr}',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Оформить button

                              Container(
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: widget.product!.isAvailable == true
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor.withOpacity(0.5),
                                ),
                                margin: EdgeInsets.zero,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onPressed: () {
                                    if (widget.product!.isAvailable!) {
                                      controller.addCart();
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20.w,
                                        width: 20.w,
                                        child: Image.asset(
                                            "assets/icons/ic_cart.png"),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        controller.count == 0
                                            ? "in_cart".tr
                                            : "+${controller.count}",
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              if (controller.count != 0)
                                Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: MaterialButton(
                                    elevation: 0,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    minWidth: 48,
                                    height: 48,
                                    onPressed: () async {
                                      await Get.offAll(
                                          () => const HomePage(initialPage: 2));
                                    },
                                    shape: const CircleBorder(
                                        side: BorderSide(
                                            color: Color(0xff777777))),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xff006266),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            : const SizedBox.shrink());
  }

  Widget itemOfCharacter(Characteristic character) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                width: (MediaQuery.of(context).size.width / 2).w,
                child: Text(
                  "${character.name}",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                character.pivot?.value ?? "",
                textScaler: TextScaler.linear(1),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
