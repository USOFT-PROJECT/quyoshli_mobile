import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quyoshli/core/app_colors.dart';
import 'package:quyoshli/pages/registration/registration_controller.dart';
import 'package:quyoshli/services/utils_service.dart';
import 'package:quyoshli/widgets/custom_button_widget.dart';
import 'package:quyoshli/widgets/filter_button_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _controller = Get.find<RegistrationController>();

  bool isPhysical = true;
  bool isLegal = false;

  @override
  void dispose() {
    Utils.phoneNumberMask.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Регистрация",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 32),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 72,
                child: Text(
                  "Вы впервые входите в систему. Зарегистрируйтесь,"
                  " чтобы завершить авторизацию",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Кто вы?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(4),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(12),
                  color: const Color.fromRGBO(
                      233, 233, 233, 1),
                ),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(
                                "isDeliverySelected selected");

                            if (!isPhysical) {
                              setState(() {
                                isPhysical = true;
                                isLegal = false;
                              });
                            }
                          },
                          child: Container(
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(12),
                              color: isPhysical
                                  ? Colors.white
                                  : Color.fromRGBO(
                                  233,
                                  233,
                                  233,
                                  1),
                            ),
                            child: Center(
                              child: Text(
                                "Я клиент",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight
                                      .w600,
                                  // color: isPhysical
                                  //     ? Color.fromRGBO(1, 162, 168, 1)
                                  //     : Color.fromRGBO(71, 71, 71, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(
                                "isIndividualSelected selected");

                            if (!isLegal) {
                              setState(() {
                                isLegal = true;
                                isPhysical = false;
                              });
                            }
                          },
                          child: Container(
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(12),
                              color: isLegal
                                  ? Colors.white
                                  : Color.fromRGBO(
                                  233,
                                  233,
                                  233,
                                  1),
                            ),
                            child: Center(
                              child: Text(
                                "Я мастер",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight
                                      .w600,
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
              ),
              const SizedBox(
                height: 32
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Личные данные",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(4),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(12),
                  color: const Color.fromRGBO(
                      233, 233, 233, 1),
                ),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(
                                "isDeliverySelected selected");

                            if (!isPhysical) {
                              setState(() {
                                isPhysical = true;
                                isLegal = false;
                              });
                            }
                          },
                          child: Container(
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(12),
                              color: isPhysical
                                  ? Colors.white
                                  : Color.fromRGBO(
                                  233,
                                  233,
                                  233,
                                  1),
                            ),
                            child: Center(
                              child: Text(
                                "Физ. лицо",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight
                                      .w600,
                                  // color: isPhysical
                                  //     ? Color.fromRGBO(1, 162, 168, 1)
                                  //     : Color.fromRGBO(71, 71, 71, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print(
                                "isIndividualSelected selected");

                            if (!isLegal) {
                              setState(() {
                                isLegal = true;
                                isPhysical = false;
                              });
                            }
                          },
                          child: Container(
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(12),
                              color: isLegal
                                  ? Colors.white
                                  : Color.fromRGBO(
                                  233,
                                  233,
                                  233,
                                  1),
                            ),
                            child: Center(
                              child: Text(
                                "Юр. лицо",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight
                                      .w600,
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
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text(
                        "Фамилия",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textFieldLabelColor),
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text(
                        "Имя",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textFieldLabelColor),
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text(
                        "Отчество",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textFieldLabelColor),
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text(
                        "Область",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textFieldLabelColor),
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text(
                        "Город",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textFieldLabelColor),
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text(
                        "Район",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.textFieldLabelColor),
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: CustomButtonWidget(
                    label: "Сохранить",
                    onPress: () {
                      _controller.goToOrdering();
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
