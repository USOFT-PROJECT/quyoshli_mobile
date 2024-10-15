import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/core/mixin/launch_mixin.dart';
import 'package:quyoshli/pages/main_subpages/usefull_detail_controller.dart';
import 'package:quyoshli/services/http_service.dart';
import 'package:quyoshli/services/log_service.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';
import 'package:quyoshli/widgets/custom_sliver_app_bar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../models/main/useful_details_model.dart';

class UsefulDetailPage extends StatefulWidget {
  const UsefulDetailPage({super.key, required this.details});

  final UsefulDetailModel details;

  @override
  State<UsefulDetailPage> createState() => _UsefulDetailPageState();
}

class _UsefulDetailPageState extends State<UsefulDetailPage> with LaunchMixin {
  final controller = Get.find<UsefullDetailController>();
  YoutubePlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    controller.details = widget.details;

    String? videoId = Utils.extractVideoId(controller.details.videoUrl!);

    if (videoId == null) {
      _videoController = YoutubePlayerController(
        params: const YoutubePlayerParams(
          mute: false,
          showControls: true,
          // showFullscreenButton: true,
        ),
      );
    } else {
      _videoController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const YoutubePlayerParams(
          mute: false,
          showControls: true,
          // showFullscreenButton: true,
        ),
      );
    }

    if (controller.details.videoUrl != null &&
        controller.details.videoUrl!.isNotEmpty) {
      _videoController!.cueVideoByUrl(
        mediaContentUrl: controller.details.videoUrl!,
      );
    }
  }

  @override
  void dispose() {
    _videoController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsefullDetailController>(
      builder: (_) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: controller.details.name ?? "",
                    isLeading: true,
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        left: 16.w,
                        right: 16.w,
                        bottom: 32.h,
                      ),
                      child: Column(
                        children: [
                          //video player
                          if (controller.details.videoUrl != null)
                            YoutubePlayer(
                              controller: _videoController!,
                              aspectRatio: 16 / 9,
                            ),
                          if (controller.details.description != null)
                            SizedBox(
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  Text(
                                    controller.details.description ?? "",
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (controller.details.fileUrl != null)
              SafeArea(
                top: false,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  width: double.infinity,
                  child: CustomButtonWidget(
                    label: 'download_file'.tr,
                    onPress: () {
                      launchInBrowser(
                          'http://${Network.getServer()}/${controller.details.fileUrl}');
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
