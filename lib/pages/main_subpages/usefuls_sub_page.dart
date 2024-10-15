import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/main_subpages/usefull_sub_controller.dart';
import 'package:quyoshli/widgets/custom_sliver_app_bar.dart';
import 'package:quyoshli/widgets/usefull_item_widget.dart';

import '../../models/main/useful_model.dart';

class UsefulsSubPage extends StatefulWidget {
  const UsefulsSubPage({super.key, required this.item});

  final UsefulModel item;

  @override
  State<UsefulsSubPage> createState() => _UsefulsSubPageState();
}

class _UsefulsSubPageState extends State<UsefulsSubPage> {
  final controller = Get.find<UsefullSubController>();

  @override
  void initState() {
    controller.getData(widget.item.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsefullSubController>(
      builder: (_) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(title: widget.item.name ?? "", isLeading: true),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(top: 8.h, bottom: 32.h, right: 16.w, left: 16.w),
                      child: Column(
                        children: [
                          ...List.generate(
                            controller.items.length,
                            (index) => GestureDetector(
                              onTap: () {
                                controller.isDocument
                                    ? controller.openDocument(
                                        controller.items[index].linkUrl)
                                    : controller.gotoUsefulSubpage(
                                        controller.items[index]);
                              },
                              child: controller.isDocument
                                  ? UsefulDocumentItem(
                                      item: controller.items[index])
                                  : UsefulSubpagetemWidget(
                                      item: controller.items[index],
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
