import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quyoshli/models/main/partners_model.dart';

import '../core/app_colors.dart';

class PartnersCard extends StatelessWidget {
  const PartnersCard({
    super.key,
    required this.partner,
  });

  final PartnerModel partner;

  @override
  Widget build(BuildContext context) {
    double size = ((MediaQuery.of(context).size.width - 48) / 2).w;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
              spreadRadius: 0,
              blurRadius: 2,
              color: Colors.black12,
              offset: Offset(0, 1)),
          BoxShadow(
              spreadRadius: 0,
              blurRadius: 8,
              color: Colors.black12,
              offset: Offset(0, 2)),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: partner.image ?? "",
                  errorWidget: (context, url, error) => Container(),
                  placeholder: (context, url) => Container(),
                  fit: BoxFit.cover,
                  width: 76.w,
                  height: 76.w,
                ),
                Flexible(
                  child: Text(
                    partner.name ?? "",
                    textScaler: TextScaler.linear(1),
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                    color: AppColors.hexToColor(partner.status?.bgColor ?? ""),
                    borderRadius: BorderRadius.circular(5.r)),
                child: Text(
                  partner.status?.translation ?? "",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                      color:
                          AppColors.hexToColor(partner.status?.fontColor ?? ""),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
