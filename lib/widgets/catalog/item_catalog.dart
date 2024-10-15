import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/catalog/catalog_model.dart';
import '../../pages/subpage/catalog_controller.dart';
import 'item_category.dart';

Widget itemOfCatalog(Catalog catalog) {
  return ExpansionTile(
    minTileHeight: 80.h,
    shape: const Border(),
    tilePadding: EdgeInsets.only(right: 16.w, left: 16.w),
    iconColor: const Color.fromRGBO(71, 71, 71, 1),
    onExpansionChanged: (bool expanded) {
      Get.find<CatalogController>().isExpanded = expanded;
      Get.find<CatalogController>().update();
    },
    title: Row(
      children: [
        CachedNetworkImage(
          height: 48.h,
          width: 48.w,
          fit: BoxFit.cover,
          imageUrl: catalog.image! ?? '',
          errorWidget: (context, urls, error) => const Icon(Icons.error),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            '${catalog.name}',
            textScaler: TextScaler.linear(1),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
    children: [
      if (Get.find<CatalogController>().isExpanded)
        const Divider(
          color: Color.fromRGBO(226, 226, 226, 1),
          height: 1,
        ),
      if (catalog.parents!.isNotEmpty)
        ...List.generate(
          catalog.parents!.length,
          (index) {
            return itemOfCategory(catalog.parents![index], 80);
          },
        ),
    ],
  );
}
