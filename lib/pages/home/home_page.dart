import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/subpage/cart_controller.dart';

import '../subpage/cart_page.dart';
import '../subpage/catalog_page.dart';
import '../subpage/main_page.dart';
import '../subpage/profile_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  final int initialPage;

  const HomePage({super.key, this.initialPage = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController? pageController;

  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    homeController.cart();
    _selectedIndex = widget.initialPage;
    pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController!.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          body: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              MainPage(
                pageController: pageController!,
              ),
              const CatalogPage(),
              CartPage(pageController: pageController!),
              const ProfilePage(),
            ],
            onPageChanged: (int index) {
              _onItemTapped(index);
            },
          ),
          bottomNavigationBar: SafeArea(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
                padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
                // viewInsets: EdgeInsets.all(10)
                // viewPadding: EdgeInsets.zero
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Color.fromRGBO(226, 226, 226, 1), width: 1),
                  ),
                ),
                child: NavigationBar(
                  height: 50,
                  indicatorColor: const Color.fromRGBO(203, 250, 252, 1),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: Colors.white,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    _onItemTapped(index);
                  },
                  destinations: [
                    NavigationDestination(
                      selectedIcon: Image.asset(
                        'assets/icons/ic_main_selected.png',
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex == 0
                            ? const Color.fromRGBO(17, 17, 17, 1)
                            : const Color.fromRGBO(71, 71, 71, 1),
                      ),
                      icon: Image.asset(
                        'assets/icons/ic_main_unselected.png',
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex == 0
                            ? const Color.fromRGBO(17, 17, 17, 1)
                            : const Color.fromRGBO(71, 71, 71, 1),
                      ),
                      label: "home".tr,
                    ),
                    NavigationDestination(
                      selectedIcon: Image.asset(
                        'assets/icons/ic_catalog_selected.png',
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex == 1
                            ? const Color.fromRGBO(17, 17, 17, 1)
                            : const Color.fromRGBO(71, 71, 71, 1),
                      ),
                      icon: Image.asset(
                        'assets/icons/ic_catalog_unselected.png',
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex == 1
                            ? const Color.fromRGBO(17, 17, 17, 1)
                            : const Color.fromRGBO(71, 71, 71, 1),
                      ),
                      label: "catalog".tr,
                    ),
                    GetBuilder<CartController>(
                      builder: (_controller) => NavigationDestination(
                        selectedIcon: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              'assets/icons/ic_cart_selected.png',
                              width: 24.w,
                              height: 24.h,
                              color: _selectedIndex == 2
                                  ? const Color.fromRGBO(17, 17, 17, 1)
                                  : const Color.fromRGBO(71, 71, 71, 1),
                            ),
                            if (_controller.cart.data!.singleProducts!.products!
                                    .isNotEmpty ||
                                _controller.cart.data!.readySolutions!.products!
                                    .isNotEmpty)
                              Container(
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              )
                          ],
                        ),
                        icon: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              'assets/icons/ic_cart_unselected.png',
                              width: 24.w,
                              height: 24.h,
                              color: _selectedIndex == 2
                                  ? const Color.fromRGBO(17, 17, 17, 1)
                                  : const Color.fromRGBO(71, 71, 71, 1),
                            ),
                            if (_controller.cart.data!.singleProducts!.products!
                                    .isNotEmpty ||
                                _controller.cart.data!.readySolutions!.products!
                                    .isNotEmpty)
                              Container(
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              )
                          ],
                        ),
                        label: "cart".tr,
                      ),
                    ),
                    NavigationDestination(
                      selectedIcon: Image.asset(
                        'assets/icons/ic_profile_selected.png',
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex == 3
                            ? const Color.fromRGBO(17, 17, 17, 1)
                            : const Color.fromRGBO(71, 71, 71, 1),
                      ),
                      icon: Image.asset(
                        'assets/icons/ic_profile_unselected.png',
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex == 3
                            ? const Color.fromRGBO(17, 17, 17, 1)
                            : const Color.fromRGBO(71, 71, 71, 1),
                      ),
                      label: "profile".tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
