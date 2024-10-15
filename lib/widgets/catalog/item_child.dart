import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/catalog/catalog_model.dart';
import '../../pages/subpage/catalog_controller.dart';

Widget itemOfChild(Catalog catalog, int categoryId) {
  return GestureDetector(
    onTap: () {
      Get.find<CatalogController>().goToProductPage(
        title: catalog.name,
        id: catalog.id,
        categoryId: categoryId,
      );
    },
    child: ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      title: Text("${catalog.name}", textScaler: TextScaler.linear(1)),
    ),
  );
}
