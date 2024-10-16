import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/main_subpages/partners_page.dart';
import 'package:quyoshli/pages/main_subpages/service_page.dart';
import 'package:quyoshli/pages/main_subpages/shimmer_home_page.dart';
import 'package:quyoshli/pages/subpage/main_controller.dart';
import 'package:quyoshli/widgets/home_all_widget.dart';
import 'package:quyoshli/widgets/home_banner_widget.dart';
import 'package:quyoshli/widgets/home_button_widget.dart';
import 'package:quyoshli/widgets/products_widget.dart';

import '../../widgets/brand_card_widget.dart';
import '../main_subpages/search_page.dart';
import '../main_subpages/useful_page.dart';

class MainPage extends StatefulWidget {
  static const String id = "main_page";
  final PageController pageController;

  const MainPage({super.key, required this.pageController});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainController = Get.find<MainController>();

  Future<void> _handleRefresh() async {
    mainController.getData();
  }

  @override
  void initState() {
    super.initState();
    mainController.pageController = PageController(viewportFraction: 0.94, initialPage: mainController.currentPage);
    mainController.getData();
    mainController.setBannerPeriodicTime();
  }

  @override
  void dispose() {
    mainController.bannerTimer.cancel(); // Cancel the timer when widget is disposed
    mainController.pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.scaffold,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: Text(
              "Quyoshli",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            leading: Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.all(7.w),
              child: Image.asset(
                "assets/images/ic_quyoshli.png",
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(const SearchPage());
                },
                child: Image.asset(
                  height: 24.w,
                  width: 24.w,
                  "assets/icons/ic_search.png",
                ),
              ),
              MaterialButton(
                minWidth: 24.w,
                onPressed: () {
                  _.gotoFavourite();
                },
                child: Image.asset(
                  height: 24.w,
                  width: 24.w,
                  "assets/icons/ic_fav.png",
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            backgroundColor: Colors.white,
            color: AppColors.mainAppColor,
            child: mainController.isLoading
                ? ShimmerHomePage()
                : SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 48.h),
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        //banner
                        SizedBox(
                          height: (MediaQuery.of(context).size.width / 2 - 10).h,
                          child: PageView.builder(
                            controller: _.pageController,
                            pageSnapping: true,
                            itemCount: _.banners.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              child: HomeBannerWidget(
                                banner: _.banners[index],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),

                        //home buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: HomeButtonWidget(
                                image: "assets/icons/ic_catalog_home.png",
                                onPress: () {
                                  widget.pageController.jumpToPage(1);
                                },
                                title: 'catalog'.tr,
                              ),
                            ),
                            Expanded(
                              child: HomeButtonWidget(
                                image: "assets/icons/ic_service.png",
                                onPress: () {
                                  _.callNextPage(ServicePage.id, context);
                                },
                                title: 'services'.tr,
                              ),
                            ),
                            Expanded(
                              child: HomeButtonWidget(
                                image: "assets/icons/ic_partners.png",
                                onPress: () {
                                  _.callNextPage(PartnersPage.id, context);
                                },
                                title: 'partner'.tr,
                              ),
                            ),
                            Expanded(
                              child: HomeButtonWidget(
                                image: "assets/icons/ic_useful.png",
                                onPress: () {
                                  Get.to(() => const UsefulPage());
                                },
                                title: 'useful'.tr,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        ...List.generate(
                          _.productList.length,
                          (index) => ProductsWidget(
                            products: _.productList[index],
                          ),
                        ),

                        SizedBox(height: 24.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                "brands".tr,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              HomeAllWidget(onPress: () {
                                Get.to(
                                  () => Scaffold(
                                    appBar: AppBar(
                                      title: Text("brands".tr,
                                        textScaler: TextScaler.linear(1),
                                      ),
                                    ),
                                    body: Container(
                                      padding: EdgeInsets.all(16.w),
                                      child: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 16.h,
                                          crossAxisSpacing: 16.w,
                                          childAspectRatio: 1 / 1,
                                        ),
                                        itemCount: _.brands.length,
                                        itemBuilder: (context, index) {
                                          var brand = _.brands[index];
                                          return BrandGridCardWidget(brand: brand);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        //brands
                        SizedBox(
                          height: 148.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _.brands.length,
                            itemBuilder: (context, index) => BrandCardWidget(
                              brand: _.brands[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
