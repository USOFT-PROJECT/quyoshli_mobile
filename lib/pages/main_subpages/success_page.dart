import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key, required this.id});

  final int id;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              "assets/icons/ic_success.png",
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "accept_request".tr,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${"number_of_request".tr}: ${widget.id}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF474747),
              ),
            ),
            Spacer(),
            CustomButtonWidget(
              label: "close".tr,
              onPress: () {
                Get.offAll(() => const HomePage(initialPage: 0));
              },
            )
          ],
        ),
      ),
    );
  }
}
