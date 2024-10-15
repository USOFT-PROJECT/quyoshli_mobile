import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/core/ext/string_ext.dart';
import 'package:quyoshli/pages/main_subpages/banner_detail_controller.dart';

class BannerDetailPage extends StatefulWidget {
  const BannerDetailPage({super.key, required this.id});

  final int? id;

  @override
  State<BannerDetailPage> createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {
  final controller = Get.find<BannerDetailController>();

  @override
  void initState() {
    controller.getDetails(widget.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerDetailController>(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.only(
            top: 8,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: controller.bannerDetail?.data?.image ?? '',
                    errorWidget: (context, url, error) => Container(),
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  controller.bannerDetail?.data?.name ?? "",
                  style: const TextStyle(
                      fontSize: 24,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Text(
                  controller.bannerDetail?.data?.createdAt != null
                      // ? DateFormat.MMMMd(Get.locale.toString()).add_Hm().format(controller.bannerDetail!.data!.createdAt!)
                      ? DateFormat('dd.MM.yyyy HH:mm').format(
                          controller.bannerDetail!.data!.createdAt! ??
                              DateTime.now())
                      : '',
                  style: const TextStyle(
                    color: Color(0xFF474747),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  (controller.bannerDetail?.data?.description ?? "")
                      .parseHtmlString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
