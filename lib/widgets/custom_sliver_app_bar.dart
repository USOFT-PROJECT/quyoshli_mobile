import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
    required this.isLeading,
  });

  final String title;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    return isLeading
        ?
        //app bar with leading
        SliverAppBar(
            surfaceTintColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 140,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // Adjust title size and behavior based on collapse percentage
                var collapseRatio = (constraints.maxHeight - kToolbarHeight) /
                    (140 - kToolbarHeight);
                bool isCollapsed =
                    collapseRatio < 0.9; // Threshold for collapsed state

                // Adjust padding if leading is present and app bar is not collapsed
                EdgeInsets titlePadding = isCollapsed
                    ? EdgeInsets.only(
                        left: 56.w,
                        bottom: 16.h,
                      ) // Shift right when leading is present
                    : EdgeInsets.only(left: 16.w, bottom: 16.h);

                return FlexibleSpaceBar(
                  expandedTitleScale: 1.2,
                  collapseMode: CollapseMode.parallax,
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      title,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 24.sp,
                        // Smaller font size when collapsed
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines:
                          isCollapsed ? 1 : 2, //// Limit lines when collapsed
                    ),
                  ),
                  titlePadding: titlePadding,
                );
              },
            ),
          ) //// app bar with leading
        :
        //appbar without leading
        SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 116.h,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // Adjust title size and behavior based on collapse percentage
                var collapseRatio = (constraints.maxHeight - kToolbarHeight) /
                    (116 - kToolbarHeight);
                bool isCollapsed =
                    collapseRatio < 0.5; // Threshold for collapsed state

                // Adjust padding if leading is present and app bar is not collapsed
                EdgeInsets titlePadding = EdgeInsets.only(left: 16.w, bottom: 16.h);

                return FlexibleSpaceBar(
                  expandedTitleScale: 1.2,
                  collapseMode: CollapseMode.parallax,
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      title,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 24.sp,
                        // Smaller font size when collapsed
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines:
                          isCollapsed ? 1 : 2,
                    ),
                  ),
                  titlePadding: titlePadding,
                );
              },
            ),
          );
  }
}

class CustomSliverAppBarWithTabBar extends StatelessWidget {
  const CustomSliverAppBarWithTabBar({
    super.key,
    required this.title,
    required this.bar,
  });

  final String title;

  final TabBar bar;

  @override
  Widget build(BuildContext context) {
    //app bar with leading
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.xmark),
        )
      ],
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 200.h,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust title size and behavior based on collapse percentage
          var collapseRatio =
              (constraints.maxHeight - kToolbarHeight) / (200 - kToolbarHeight);
          bool isCollapsed =
              collapseRatio < 0.9; // Threshold for collapsed state

          // Adjust padding if leading is present and app bar is not collapsed
          EdgeInsets titlePadding = isCollapsed
              ? const EdgeInsets.only(
                  left: 56,
                  right: 56,
                  bottom: 60)
              : const EdgeInsets.only(left: 16, bottom: 60);

          return FlexibleSpaceBar(
            expandedTitleScale: 1.2,
            collapseMode: CollapseMode.parallax,
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                title,
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 24.sp,
                  // Smaller font size when collapsed
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: isCollapsed ? 1 : 2,
              ),
            ),
            titlePadding: titlePadding,
          );
        },
      ),
      bottom: bar,
    ); //// app bar with leading
  }
}
