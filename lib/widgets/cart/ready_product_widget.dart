import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:quyoshli/models/cart/cart_model.dart';
import 'package:quyoshli/services/utils_service.dart';

class ReadyProductWidget extends StatelessWidget {
  const ReadyProductWidget(
      {super.key,
      required this.product,
      required this.delete,
      required this.increase,
      required this.decrease});

  final Product product;
  final Function delete;
  final Function increase;
  final Function decrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140.h,
      padding: EdgeInsets.only(top: 16.h, bottom: 15.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(226, 226, 226, 1),
            // width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // product image
              CachedNetworkImage(
                width: 110.w,
                height: 110.w,
                fit: BoxFit.cover,
                imageUrl: product.poster ?? "",
                placeholder: (context, urls) => Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                errorWidget: (context, urls, error) => const Icon(Icons.error),
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
          
              SizedBox(width: 16.w),
          
              // details
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      product.name ?? "",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (product.priceDiscount != 0 &&
                                    product.priceDiscount != null)
                                  Text(
                                    Utils.putSpace("${product.price ?? ""}"),
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                      color: Color.fromRGBO(119, 119, 119, 1),
                                    ),
                                  )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${Utils.putSpace("${product.priceDiscount != 0 && product.priceDiscount != null ? product.priceDiscount : product.price ?? ""}")} ${"currency".tr}",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text.rich(
                              textScaleFactor: 1.0,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'in_stock'.tr,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  product.availableCount != 0
                                      ? TextSpan(
                                          text:
                                              '${product.availableCount ?? ""} ${"count_symbol".tr}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(0, 168, 0, 1),
                                          ),
                                        )
                                      : TextSpan(
                                          text: 'no'.tr,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFD6191D),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                     
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // + - cost

          Container(
            // color: Colors.green,
            height: 32.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 110.w,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // "-" button
                          GestureDetector(
                            onTap: () {
                              Utils.vibrate();
                              decrease(product.id);
                            },
                            child: Container(
                              width: 32.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(119, 119, 119, 1),
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Center(
                                child: Container(
                                  width: 16.w,
                                  height: 16.w,
                                  child:
                                      Image.asset('assets/icons/ic_minus.png'),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),

                          Text(
                            "${product.count ?? ""}",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Spacer(),
                          // "+" button
                          GestureDetector(
                            onTap: () {
                              Utils.vibrate();
                              increase(product.id);
                            },
                            child: Container(
                              width: 32.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(119, 119, 119, 1)),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child:
                                      Image.asset('assets/icons/ic_plus.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "${Utils.putSpace(product.priceTotal.toString()) ?? ""} ${"currency".tr}",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Utils.vibrate();
                    delete(product);
                  },
                  child: Image(
                    width: 30.h,
                    image: AssetImage("assets/icons/ic_cart_remove.png"),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
