import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quyoshli/models/profile/my_orders_model.dart';
import 'package:quyoshli/services/utils_service.dart';

import '../../services/http_service.dart';
import '../../services/log_service.dart';
import 'my_orders_controller.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final controller = Get.find<MyOrdersController>();
  bool isLoading = true;

  List<Order> orders = [];

  apiOrders() async {
    try {
      var response = await Network.GET(Network.API_ORDERS_LIST, {});
      OrderModel orderModel = orderModelFromJson(response!);

      setState(() {
        orders.addAll(orderModel.data!);
        isLoading = false;
      });

      LogService.i(orders.length.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    apiOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "my_orders".tr,
          textScaler: TextScaler.linear(1),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isNotEmpty
              ? Container(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemOfOrders(orders[index]);
                    },
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80.w,
                        width: 80.w,
                        child: Image.asset(
                          "assets/icons/ic_catalog.png",
                          fit: BoxFit.cover,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "no_orders".tr,
                        textScaler: TextScaler.linear(1),
                      )
                    ],
                  ),
                ),
    );
  }

  Widget itemOfOrders(Order order) {
    return GestureDetector(
      onTap: () {
        controller.goToActiveOrderCheckPage(order.id.toString());
      },
      child: Container(
        // height: 116,
        width: double.infinity,
        margin: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, right: 16.w, left: 16.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 234, 231, 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"order".tr} №${order.id}",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(0, 135, 0, 1),
                  ),
                  child: Center(
                    child: Text(
                      "${order.status?.translation}",
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "${"created_time".tr} ${DateFormat('dd.MM.yyyy HH:mm').format(order.createdAt ?? DateTime.now())}",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 2.h,
              width: double.infinity,
              color: const Color.fromRGBO(168, 172, 168, 1),
            ),
            SizedBox(height: 12.h),
            Text(
              "${"order_total".tr} ${Utils.putSpace(order.totalAmount.toString())} ${"currency".tr}",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
