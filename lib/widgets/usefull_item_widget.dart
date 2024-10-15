import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/models/main/useful_model.dart';

import '../models/main/useful_details_model.dart';

class UsefulItemWidget extends StatelessWidget {
  const UsefulItemWidget(
      {super.key, required this.item, required this.hasImage});

  final UsefulModel item;
  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasImage)
            Container(
              alignment: Alignment.center,
              width: 40.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(12.r)),
              child: CachedNetworkImage(
                imageUrl: item.image ?? "",
                height: 20.w,
                width: 20.w,
              ),
            ),
          SizedBox(width: 16.w),
          Text(
            item.name ?? "",
            textScaler: TextScaler.linear(1),
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          Image.asset(
            "assets/icons/ic_useful_arrow.png",
            width: 24.w,
            height: 24.w,
          )
        ],
      ),
    );
  }
}

class UsefulSubpagetemWidget extends StatelessWidget {
  const UsefulSubpagetemWidget({
    super.key,
    required this.item,
  });

  final UsefulDetailModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              item.name ?? "",
              textScaler: TextScaler.linear(1),
              maxLines: 3,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(width: 9.w),
          Image.asset(
            "assets/icons/ic_useful_arrow.png",
            width: 24.w,
            height: 24.w,
          )
        ],
      ),
    );
  }
}

class UsefulDocumentItem extends StatelessWidget {
  const UsefulDocumentItem({super.key, required this.item});

  final UsefulDetailModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              item.name ?? "",
              textScaler: TextScaler.linear(1),
              maxLines: 3,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(width: 9.w),
          Image.asset(
            "assets/icons/ic_useful_share.png",
            width: 24.w,
            height: 24.w,
          )
        ],
      ),
    );
  }
}
