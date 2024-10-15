import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/main_subpages/partners_page_controller.dart';
import 'package:quyoshli/widgets/partners_card.dart';

class PartnersPage extends StatefulWidget {
  static const String id = "partners_page";

  const PartnersPage({super.key});

  @override
  State<PartnersPage> createState() => _PartnersPageState();
}

class _PartnersPageState extends State<PartnersPage> {
  final controller = Get.find<PartnersPageController>();

  @override
  void initState() {
    controller.getPartners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnersPageController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: false,
          title: Text(
            "partner".tr,
            textScaler: TextScaler.linear(1),
            style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 16.h, bottom: 32.h, left: 16.w, right: 16.w),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.partners.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (controller.partners[index].status != 'soon') {
                    controller.gotoPartnerDetail(controller.partners[index]);
                  }
                },
                child: PartnersCard(
                  partner: controller.partners[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
