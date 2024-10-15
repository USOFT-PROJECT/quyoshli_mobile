import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/brand_list_model.dart';
import 'package:quyoshli/pages/main_subpages/brand_products_page.dart';

class BrandCardWidget extends StatelessWidget {
  const BrandCardWidget({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BrandProductsPage(brandModel: brand));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        // width: 148,
        // height: 148,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: CachedNetworkImage(
          imageUrl: brand.image ?? "",
          errorWidget: (context, url, error) => Container(),
        ),
      ),
    );
  }
}

class BrandGridCardWidget extends StatelessWidget {
  const BrandGridCardWidget({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BrandProductsPage(brandModel: brand));
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: CachedNetworkImage(
          imageUrl: brand.image ?? "",
          errorWidget: (context, url, error) => Container(),
        ),
      ),
    );
  }
}

class BrandCardWidget2 extends StatelessWidget {
  const BrandCardWidget2({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      height: (MediaQuery.of(context).size.width - 48) / 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E2E2)),
      ),
      child: CachedNetworkImage(
        imageUrl: brand.image ?? "",
        errorWidget: (context, url, error) => Container(),
      ),
    );
  }
}
