import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/models/main/services_model.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    double size = ((MediaQuery.of(context).size.width - 48) / 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
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
            alignment: Alignment.center,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: service.image ?? "",
                      errorWidget: (context, url, error) => Container(),
                      width: 60.w,
                      height: 60.w,
                    ),
                    SizedBox(
                      height: 10.h
                    ),
                    Text(
                      service.name ?? "",
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if(service.status?.slug != "published")
              Container(
                alignment: Alignment.topRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    height: 20.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                        color: AppColors.hexToColor(service.status?.bgColor ?? ""),
                        borderRadius: BorderRadius.circular(4.r)),
                    child: Text(
                      service.status?.translation ?? "",
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                          color: AppColors.hexToColor(
                              service.status?.fontColor ?? ""),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
