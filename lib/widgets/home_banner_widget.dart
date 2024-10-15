import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quyoshli/models/main/banner_model.dart';
import 'package:quyoshli/pages/main_subpages/banner_detail_page.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BannerDetailPage(
              id: banner.id,
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: banner.image!,
                errorWidget: (context, url, error) => Container(
                  color: CupertinoColors.systemGrey4,
                ),
                placeholder: (context, url) => Container(
                  color: CupertinoColors.systemGrey4,
                ),
                fit: BoxFit.cover,
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   alignment: Alignment.bottomLeft,
            //   child: Text(
            //     banner.name ?? "",
            //     style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //         color: CupertinoColors.white),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
