import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/bottomsheet/bottomsheet.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quyoshli/models/profile/about_model.dart';

class AboutPage extends StatefulWidget {
  final AboutApp? info;

  const AboutPage({super.key, required this.info});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late AboutApp info;
  String appVersion = "";

  @override
  void initState() {
    // _getAppVersion();
    super.initState();
    _getAppVersion();

    info = widget.info!;
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.data.name ?? "",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24.h),
            Html(
              data: info.data.body ?? '',
              style: {
                "html": Style(
                  margin: Margins.zero,  // Remove default margin
                  padding: HtmlPaddings.zero, // Remove default padding if any
                ),
                "body": Style(
                  margin: Margins.zero,  // Remove margin for <body> tag
                ),
                "p": Style(
                  margin: Margins.zero,  // Remove margin for <p> tags
                ),
              },
            ),
            SizedBox(height: 24.h),
            Text(
              "${"app_version".tr} $appVersion",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
