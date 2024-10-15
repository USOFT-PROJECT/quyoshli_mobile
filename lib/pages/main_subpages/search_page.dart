import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/main_subpages/favourite_shimer_page.dart';
import 'package:quyoshli/pages/main_subpages/search_controller.dart';

import '../../widgets/card_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = Get.find<SearchPageController>();

  @override
  void initState() {
    //controller.searchAPI("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Expanded(
                child: MediaQuery(
                  data:
                      const MediaQueryData(textScaler: TextScaler.linear(1.0)),
                  child: TextField(
                    controller: controller.searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      controller.search(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "search".tr,
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(CupertinoIcons.xmark_circle),
                  onPressed: () {
                    controller.searched = false;
                    controller.products.clear();
                    controller.clearTextField();
                    controller.update();
                  },
                )
            ],
          ),
        ),
        body: controller.isLoading
            ? Container(
                padding: EdgeInsets.only(
                    top: 8.h, bottom: 24.h, left: 16.w, right: 16.w),
                child: FavouriteShimmerPage())
            : controller.products.isNotEmpty
                ? Container(
                    padding: EdgeInsets.only(
                        top: 8.h, bottom: 24.h, left: 16.w, right: 16.w),
                    child: GridView.builder(
                      //shrinkWrap: true,
                      // Let GridView take only as much space as it needs
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 1 / 1.6,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.goToDetailsProduct(
                                controller.products[index], index);
                          },
                          behavior: HitTestBehavior.translucent,
                          child: FavCard(
                            product: controller.products[index],
                          ),
                        );
                      },
                    ),
                  )
                : controller.searched
                    ? SizedBox(
                        height: double.infinity,
                        child: Column(
                          children: [
                            const Divider(),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    "assets/icons/ic_search2.png",
                                    width: 80.w,
                                    height: 80.w,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    "empty_info_search".tr,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0xFF474747),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
      ),
    );
  }
}
