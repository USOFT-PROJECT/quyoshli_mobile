import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/catalog/item_catalog.dart';
import 'catalog_controller.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<CatalogController>().getCatalogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "catalog".tr,
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GetBuilder<CatalogController>(
        builder: (controller) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.catalogs.length,
            itemBuilder: (context, index) {
              return Theme(
                data: Theme.of(context).copyWith(
                  listTileTheme: const ListTileThemeData(
                    selectedColor: Colors.transparent,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: itemOfCatalog(controller.catalogs[index]),
              );
            },
          );
        },
      ),
    );
  }
}
