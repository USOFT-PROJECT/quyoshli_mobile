import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quyoshli/config/root_binding.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/models/profile/order_show_model.dart';
import 'package:styled_divider/styled_divider.dart';

import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../services/utils_service.dart';

class OrderCheckPage extends StatefulWidget {
  final String id;

  const OrderCheckPage({super.key, required this.id});

  @override
  State<OrderCheckPage> createState() => _OrderCheckPageState();
}

class _OrderCheckPageState extends State<OrderCheckPage> {
  bool isLoading = true;
  OrderShow order = OrderShow();
  String orderId = '';

  getDetailOrder() async {
    try {
      var response = await Network.GET(
          Network.API_ORDER_SHOW.replaceFirst(':order_id', orderId), {});

      setState(() {
        order = orderShowModelFromJson(response!).order!;
        isLoading = false;
      });
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderId = widget.id;

    getDetailOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "${"order".tr} №${order.id ?? ''}",
          textScaler: TextScaler.linear(1),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Детали заказа
                    Row(
                      children: [
                        Text(
                          "order_detail".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "order_number".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${order.id ?? ''}",
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "order_status".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: const Color.fromRGBO(0, 135, 0, 1),
                          ),
                          child: Text(
                            order.status?.translation ?? '',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "payment_status".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: const Color.fromRGBO(0, 135, 0, 1),
                          ),
                          child: Text(
                            order.paymentStatus?.translation ?? '',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "created_time".tr,
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('dd.MM.yyyy HH:mm')
                              .format(order?.createdAt ?? DateTime.now()),
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // С установкой
                    order.withInstallation == true
                        ? Column(
                            children: [
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "installation_type".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "with_installation".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "cost_installation".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${Utils.putSpace(order.priceMaster!.decimal.toString())} ${"currency".tr}",
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),

                    SizedBox(height: 32.h),

                    StyledDivider(
                      height: 1.h,
                      color: Color.fromRGBO(168, 172, 168, 1),
                      lineStyle: DividerLineStyle.dashed,
                    ),

                    SizedBox(height: 32.h),

                    // Список покупок
                    Row(
                      children: [
                        Text(
                          "shopping_list".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.h),

                    Column(
                      children:
                          List.generate(order.products?.length ?? 0, (index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${order.products?[index].count}x ${order.products?[index].name}",
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${Utils.putSpace(order.products![index].totalPrice.toString())} ${"currency".tr}",
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                          ],
                        );
                      }),
                    ),

                    SizedBox(height: 20.h),
                    StyledDivider(
                      height: 1.h,
                      color: Color.fromRGBO(168, 172, 168, 1),
                      lineStyle: DividerLineStyle.dashed,
                    ),

                    SizedBox(height: 32.h),

                    // Информация о клиенте
                    Row(
                      children: [
                        Text(
                          "client_info".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Физ. лицо
                    if (order.clientType == "physical")
                      // Физ. лицо
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "client_type".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "physical".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "full_name".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.clientInformation?.fullName}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "phone".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                Utils.formatPhoneNumberWithMask(
                                    "${order.clientInformation?.phone}"),
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    if (order.clientType == "legal")
                      // Юр. лицо
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "client_type".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "legal".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "company_name".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.companyName}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "inn".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.inn}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "director_fio".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.directorFullName}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "bank".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width / 2).w,
                                child: Text(
                                  "${order.legalInformation?.bankName}",
                                  textScaler: TextScaler.linear(1),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "mfo".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.mfo}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "acc_number".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.paymentAccount}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "oked".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.oked}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${"address".tr}:",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.address}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "email".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${order.legalInformation?.email}",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "phone".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                Utils.formatPhoneNumberWithMask(
                                    "${order.legalInformation?.phone}"),
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    SizedBox(height: 32.h),

                    StyledDivider(
                      height: 1.h,
                      color: Color.fromRGBO(168, 172, 168, 1),
                      lineStyle: DividerLineStyle.dashed,
                    ),

                    SizedBox(height: 32.h),

                    // delivery
                    Row(
                      children: [
                        Text(
                          "delivery_details".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "delivery_type".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          order.deliveryType == "pickup"
                              ? "pickup".tr
                              : "delivery".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.deliveryType == "pickup"
                              ? "pickup_address".tr
                              : "delivery_address".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 2),
                          child: Text(
                            textAlign: TextAlign.end,
                            textScaler: TextScaler.linear(1),
                            order.deliveryType == "pickup"
                                ? "${order.branch?.address}"
                                : "${order.address?.city?.name}, ${order.address?.city?.region?.name}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                    order.deliveryType != "pickup"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "delivery_cost".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2),
                                child: Text(
                                  textAlign: TextAlign.end,
                                  textScaler: TextScaler.linear(1),
                                  "${order.priceDelivery?.decimal} ${"currency".tr}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),

                    SizedBox(height: 32.h),

                    StyledDivider(
                      height: 1.h,
                      color: Color.fromRGBO(168, 172, 168, 1),
                      lineStyle: DividerLineStyle.dashed,
                    ),

                    SizedBox(height: 32.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "total".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.end,
                          "${Utils.putSpace(order.totalAmount.toString())} ${"currency".tr}",
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 48.h),
                  ],
                ),
              ),
            ),
    );
  }
}
