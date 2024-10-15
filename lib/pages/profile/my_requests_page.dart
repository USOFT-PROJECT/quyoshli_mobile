import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quyoshli/models/profile/my_requests_model.dart';
import 'package:quyoshli/pages/profile/my_requests_controller.dart';

import '../../services/http_service.dart';
import '../../services/log_service.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  final controller = Get.find<MyRequestsController>();

  List<Request> requests = [];
  late RequestModel requestModel;
  bool isLoading = true;

  apiRequests() async {
    try {
      var response = await Network.GET(Network.API_REQUESTS_LIST, {});
      requestModel = requestModelFromJson(response!);

      setState(() {
        requests.addAll(requestModel.data!);
        isLoading = false;
      });

      LogService.i(requests.length.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    apiRequests();
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
          "my_requests".tr,
          textScaler: TextScaler.linear(1),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requests.isNotEmpty
              ? Container(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: requests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemOfRequests(requests[index]);
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
                        "no_requests".tr,
                        textScaler: TextScaler.linear(1),
                      )
                    ],
                  ),
                ),
    );
  }

  Widget itemOfRequests(Request request) {
    return GestureDetector(
      onTap: () {
        controller.goRequestShowPage(request.id.toString());
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 8.h, right: 16.w, left: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(241, 241, 241, 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${"request".tr} №${request.id}",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color.fromRGBO(0, 135, 0, 1),
                  ),
                  child: Center(
                    child: Text(
                      "${request.status?.translation}",
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
              "${"created_time".tr} ${DateFormat('dd.MM.yyyy HH:mm').format(request.createdAt ?? DateTime.now())}",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
