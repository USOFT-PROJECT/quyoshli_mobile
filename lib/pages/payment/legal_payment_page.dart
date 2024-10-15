import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/payment/legal_payment_controller.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';

import '../../widgets/custom_textfield.dart';

class LegalPaymentPage extends StatefulWidget {
  const LegalPaymentPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<LegalPaymentPage> createState() => _LegalPaymentPageState();
}

class _LegalPaymentPageState extends State<LegalPaymentPage> {
  final controller = Get.find<LegalPaymentController>();

  @override
  void initState() {
    controller.init(widget.data);
    controller.apiLoadPaymentSystem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LegalPaymentController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "payment".tr,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 32, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(233, 233, 233, 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.choosePaymentType(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: controller.payWithBank
                                  ? Colors.white
                                  : const Color.fromRGBO(233, 233, 233, 1),
                            ),
                            child: Center(
                              child: Text(
                                "list".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.choosePaymentType(false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: !controller.payWithBank
                                  ? Colors.white
                                  : Color.fromRGBO(233, 233, 233, 1),
                            ),
                            child: Center(
                              child: Text(
                                "cash".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  // color: isLegal
                                  //     ? Color.fromRGBO(1, 162, 168, 1)
                                  //     : Color.fromRGBO(71, 71, 71, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                controller.payWithBank
                    ?
                    //pay with bank,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            "detail_legal".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                            label: "company_name".tr,
                            textEditingController: controller.companyName,
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: "inn".tr,
                            textEditingController: controller.inn,
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: "director_fio".tr,
                            textEditingController: controller.fioDirector,
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: "bank".tr,
                            textEditingController: controller.bank,
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: "mfo".tr,
                            textEditingController: controller.mfo,
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: "oked".tr,
                            textEditingController: controller.oked,
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: "legal_address".tr,
                            textEditingController: controller.legalAddress,
                            enabled: false,
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Checkbox(
                                value: controller.withDidox,
                                onChanged: (value) =>
                                    controller.onDioxChange(value!),
                                activeColor: const Color(0xFF01A2A8),
                              ),
                              Text(
                                "send_via_didox".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                              )
                            ],
                          ),
                        ],
                      )
                    :
                    //pay with cash
                    Column(
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/ic_how_to_use.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  controller.paymentTypes.isNotEmpty
                                      ? controller.paymentTypes[0].systems![0]
                                              .description ??
                                          ''
                                      : '',
                                  maxLines: null,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 32)
                        ],
                      ),
                CustomButtonWidget(
                  label: "draw_contract".tr,
                  onPress: () {
                    controller.pay(widget.data);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
