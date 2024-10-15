import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/main_subpages/useful_controller.dart';
import 'package:quyoshli/widgets/custom_sliver_app_bar.dart';
import 'package:quyoshli/widgets/usefull_item_widget.dart';

class UsefulPage extends StatefulWidget {
  const UsefulPage({super.key});

  @override
  State<UsefulPage> createState() => _UsefulPageState();
}

class _UsefulPageState extends State<UsefulPage> {
  final controller = Get.find<UsefulController>();

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsefulController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // SliverAppBar with back button and title
              CustomSliverAppBar(title: "useful".tr, isLeading: true),

              // Form section
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 32.h),
                      child: Column(
                        children: [
                          ...List.generate(
                            controller.items.length,
                            (index) => GestureDetector(
                              onTap: () {
                                controller.gotoUsefulSubpage(controller.items[index]);
                              },
                              child: UsefulItemWidget(
                                item: controller.items[index],
                                hasImage: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
