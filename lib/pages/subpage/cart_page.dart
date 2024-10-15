import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/subpage/cart_controller.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/cart/cart_shimmer_page.dart';
import 'package:quyoshli/widgets/cart/sing_product_widget.dart';
import 'package:quyoshli/widgets/cart/unavailable_product_widget.dart';
import 'package:styled_divider/styled_divider.dart';

import '../../widgets/cart/empty_cart_widget.dart';
import '../../widgets/cart/ready_product_widget.dart';
import '../../widgets/custom_button_widget.dart';

class CartPage extends StatefulWidget {
  final PageController pageController;

  const CartPage({super.key, required this.pageController});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final controller = Get.find<CartController>();

  Future<void> _handleRefresh() async {
    _loadInitData();
  }

  _loadInitData() {
    controller.getData();
  }

  @override
  void initState() {
    super.initState();
    _loadInitData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Text(
            "basket".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: controller.isLoading
              ? CartShimmerPage()
              : controller.isEmpty
                  ? emptyCartWidget(context, widget.pageController)
                  : SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 8.h,
                          bottom: 32.h,
                          left: 16.w,
                          right: 16.w,
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //ready solution
                            if (controller.cart.data!.readySolutions!.products!
                                .isNotEmpty)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "ready_solution".tr,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ready products
                                  ...List.generate(
                                    controller.cart.data!.readySolutions!
                                        .products!.length,
                                    (index) {
                                      var product = controller.cart.data!
                                          .readySolutions!.products![index];
                                      //checking if there are unavailable product
                                      if (product.availableCount! == 0) {
                                        controller.readyUnavailableProduct =
                                            true;
                                      }
                                      return ReadyProductWidget(
                                        product: controller.cart.data!
                                            .readySolutions!.products![index],
                                        delete: controller.deleteItem,
                                      );
                                    },
                                  ),

                                  SizedBox(height: 16.h),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "your_order".tr,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${controller.readySolutionsCount} ${"items".tr}",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${Utils.putSpace("${controller.cart.data!.readySolutions!.price ?? ""}")} ${"currency".tr}",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 12.h),
                                          if (controller.cart.data
                                                  ?.readySolutions?.discount !=
                                              0)
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "product_discount".tr,
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                if (controller
                                                            .cart
                                                            .data
                                                            ?.readySolutions
                                                            ?.discount !=
                                                        0 &&
                                                    controller
                                                            .cart
                                                            .data
                                                            ?.readySolutions
                                                            ?.discount !=
                                                        null)
                                                  Text(
                                                    "${Utils.putSpace("-${controller.cart.data?.readySolutions?.discount ?? ""}")} ${"currency".tr}",
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 15.5.h),

                                      StyledDivider(
                                        height: 1.h,
                                        lineStyle: DividerLineStyle.dashed,
                                        color: Color.fromRGBO(226, 226, 226, 1),
                                      ),

                                      SizedBox(height: 15.5.h),

                                      // Итого:
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "total".tr,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${Utils.putSpace("${controller.cart.data!.readySolutions!.total ?? ""}")} ${"currency".tr}",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                  if (controller.readyUnavailableProduct ??
                                      false)
                                    const UnavailableProductWidget(),
                                  SizedBox(height: 16.h),
                                  // cost and pay button
                                  controller.readyUnavailableProduct == null ||
                                          !controller.readyUnavailableProduct!
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: CustomButtonWidget(
                                            label: "design".tr,
                                            onPress: () {
                                              controller.apply(false);
                                            },
                                          ),
                                        )
                                      : Container(
                                          height: 48.h,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff1111111f),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: Text(
                                            "design".tr,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                ],
                              ),

                            SizedBox(height: 16.h),

                            //products
                            if (controller.cart.data!.singleProducts!.products!
                                .isNotEmpty)
                              Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  Row(
                                    children: [
                                      Text(
                                        "products".tr,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),

                                  //single products
                                  ...List.generate(
                                    controller.cart.data!.singleProducts!
                                        .products!.length,
                                    (index) {
                                      var product = controller.cart.data!
                                          .singleProducts!.products![index];

                                      if (product.availableCount == 0) {
                                        controller.singleUnavailableProduct =
                                            true;
                                      }
                                      return SingleProductWidget(
                                        product: product,
                                        increase: controller.addItem,
                                        decrease: controller.removeItem,
                                        delete: controller.deleteItem,
                                      );
                                    },
                                  ),

                                  SizedBox(height: 16.h),

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "your_order".tr,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${controller.singleProductsCount} ${"items".tr}",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${Utils.putSpace("${controller.cart.data!.singleProducts!.price ?? ""}")} ${"currency".tr}",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 12.h),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "product_discount".tr,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "- ${Utils.putSpace((controller.cart.data!.singleProducts!.discount!).toString())} ${"currency".tr}",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15.5.h),

                                      StyledDivider(
                                        thickness: 1.h,
                                        lineStyle: DividerLineStyle.dashed,
                                      ),

                                      SizedBox(height: 15.5.h),

                                      // Итого:
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "total".tr,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${Utils.putSpace(controller.cart.data!.singleProducts!.total.toString())} ${"currency".tr}",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),

                                      if (controller.singleUnavailableProduct ??
                                          false)
                                        const UnavailableProductWidget()
                                    ],
                                  ),

                                  SizedBox(height: 16.h),

                                  // cost and pay button
                                  SizedBox(
                                    width: double.infinity,
                                    child: controller
                                                    .singleUnavailableProduct ==
                                                null ||
                                            !controller
                                                .singleUnavailableProduct!
                                        ? CustomButtonWidget(
                                            label: "design".tr,
                                            onPress: () {
                                              controller.apply(true);
                                            },
                                          )
                                        : Container(
                                            height: 48.h,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff1111111f),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Text(
                                              "design".tr,
                                              textScaler: TextScaler.linear(1),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(height: 32.h),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
