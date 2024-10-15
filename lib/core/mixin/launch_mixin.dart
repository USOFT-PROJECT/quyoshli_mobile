import 'dart:developer';

import 'package:url_launcher/url_launcher_string.dart';

mixin LaunchMixin {
  Future<void> launchInBrowser(
    String url, {
    LaunchMode mode = LaunchMode.inAppBrowserView,
  }) async {
    try {
      if (!await launchUrlString(
        url,
        mode: mode,
      )) {
        log('Could not launch $url');
      }
    } catch (e) {
      log('Could not launch $e');
    }
  }
}
