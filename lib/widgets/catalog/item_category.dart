import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/catalog/catalog_model.dart';
import 'item_child.dart';

Widget itemOfCategory(Catalog catalog, double padding) {
  return catalog.parents!.isNotEmpty
      ? Padding(
          padding: EdgeInsets.only(left: padding),
          child: ExpansionTile(
            minTileHeight: 48.h,
            collapsedBackgroundColor: Colors.transparent,
            shape: const Border(),
            tilePadding: EdgeInsets.only(right: 16.w, left: 0),
            iconColor: const Color.fromRGBO(71, 71, 71, 1),
            title: Text("${catalog.name}", textScaler: TextScaler.linear(1),),
            children: [
              if (catalog.parents!.isNotEmpty)
                ...List.generate(catalog.parents!.length, (index) {
                  return itemOfCategory(catalog.parents![index], 24);
                }),
            ],
          ),
        )
      : Padding(
          padding: EdgeInsets.only(left: padding),
          child: itemOfChild(catalog, catalog.id!),
        );
}
