import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/main_subpages/service_page_controller.dart';
import 'package:quyoshli/widgets/service_card.dart';

class ServicePage extends StatefulWidget {
  static const String id = "service_page";

  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final controller = Get.find<ServicePageController>();

  @override
  void initState() {
    controller.getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicePageController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text(
            "services".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textColor,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 16.h, left: 8.w, right: 8.w, bottom: 32.h),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.services[index].status?.slug != 'soon') {
                          controller.callNextPage(controller.services[index]);
                        }
                      },
                      child: ServiceCard(
                        service: controller.services[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
