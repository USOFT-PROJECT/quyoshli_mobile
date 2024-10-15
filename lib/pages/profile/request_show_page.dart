import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quyoshli/config/root_binding.dart';
import 'package:quyoshli/core/ext/num_ext.dart';
import 'package:quyoshli/models/profile/request_show_model.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:styled_divider/styled_divider.dart';

class RequestShowPage extends StatefulWidget {
  final RequestShow? request;

  const RequestShowPage({super.key, required this.request});

  @override
  State<RequestShowPage> createState() => _OrderCheckPageState();
}

class _OrderCheckPageState extends State<RequestShowPage> {
  late RequestShow? request;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request = widget.request;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("${"request".tr} №${request!.id}", textScaler: TextScaler.linear(1),),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Container(
                height: 4.h,
                width: 108.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.h),

              // Детали заявки
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "request_detail".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "request_type".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2).w,
                        child: Text(
                          textAlign: TextAlign.end,
                          "${request!.service?.name}",
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                       Expanded(
                        child: Text(
                          "request_number".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${request!.id?.decimal}",
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
                    children: [
                      Expanded(
                        child: Text(
                          "request_status".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // request status
                      Container(
                        // width: 72,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: const Color.fromRGBO(0, 135, 0, 1),
                        ),
                        child: Center(
                          child: Text(
                            "${request?.status?.translation}",
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
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
                      // request status
                      Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(
                            request?.service?.createdAt ?? DateTime.now()),
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 12.sp,
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

              // Детали сервиса
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "service_details".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  (request!.service!.isPower == true)
                      ? Column(
                          children: [
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${"power".tr}:",
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${request?.power?.power ?? ""}",
                                  textScaler: TextScaler.linear(1),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  (request!.service!.withProblem == true)
                      ? Column(
                          children: [
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${"problem".tr}:",
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2).w,
                                  child: Text(
                                    request?.problem?.title ?? "",
                                    textScaler: TextScaler.linear(1),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),

                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${"address".tr}:",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2).w,
                        child: Text(
                          "${request?.city?.name}, ${request?.city?.region?.name}",
                          textScaler: TextScaler.linear(1),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
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
                        "${"full_name".tr}:",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2).w,
                        child: Text(
                          "${request?.fullName}",
                          textScaler: TextScaler.linear(1),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
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
                        "${"phone".tr}:",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2),
                        child: Text(
                          Utils.formatPhoneNumber("${request?.phone}"),
                          textScaler: TextScaler.linear(1),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
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
                        "${"comment".tr}:",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2).w,
                        child: Text(
                          "${request?.comment}",
                          textScaler: TextScaler.linear(1),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
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
            ],
          ),
        ),
      ),
    );
  }
}
