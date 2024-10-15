import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/profile/feedback_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class UnsuccessfullPaymentController extends GetxController{
  late FeedbackRes feedback;

  getFeedback() async {
    try {
      var response = await Network.GET(Network.API_FEEDBACK, {});

      feedback = feedbackModelFromJson(response!).data!;
      update();
    } catch (e) {
      LogService.e(e.toString());
    }
  }


  Future<void> launchUrls(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}