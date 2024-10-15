import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quyoshli/pages/subpage/profile_controller.dart';
import '../../widgets/custom_textfield.dart';
import 'my_info_controller.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final controller = Get.find<MyInfoController>();

  @override
  void initState() {
    controller.apiLoadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: Text(
              "edit_profile".tr,
              textScaler: TextScaler.linear(1),

              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),

                // profile image
                Container(
                  padding: EdgeInsets.all(32.w),
                  height: 120.w,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(203, 250, 252, 1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Image.asset("assets/icons/ic_default_profile.png"),
                ),

                SizedBox(height: 32.h),

                // inputs
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  // height: 272,
                  child: Column(
                    children: [
                      // Surname | Фамилия
                      CustomTextField(
                        label: "lastname".tr,
                        textEditingController: controller.lastNameController,
                      ),

                      SizedBox(height: 16.h),

                      // Name | Имя
                      CustomTextField(
                          label: "firstname".tr,
                          textEditingController: controller.firstNameController,
                      ),

                      const SizedBox(height: 16),

                      // Отчество
                      CustomTextField(
                        label: "middle_name".tr,
                        textEditingController: controller.middleNameController,
                      ),

                      SizedBox(height: 16.h),

                      // phone number
                      Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Container(
                          height: 40.h,
                          margin: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
                          child: MediaQuery(
                            data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
                            child: TextField(
                              textCapitalization: TextCapitalization.words,
                              controller: controller.phoneNumberController,
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              // maxLines: null,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                label: Text(
                                  "phone".tr,
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color.fromRGBO(71, 71, 71, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              // enabled: enabled,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                GestureDetector(
                  onTap: () {
                    controller.dialogDeleteUser(context);
                  },
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 12.h),
                    child: Text(
                      "delete_acc".tr,
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(214, 25, 29, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            // minimum: EdgeInsets.only(bottom: 16),
            // bottom: true,
            child: Container(
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // margin: EdgeInsets.only(bottom: 16.h),
              decoration: const BoxDecoration(
                // color: Colors.green,
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(226, 226, 226, 1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color.fromRGBO(119, 119, 119, 1),
                        ),
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          "cancel".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 98, 102, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromRGBO(3, 55, 57, 1),
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        onPressed: (){
                          if (controller.firstNameController.text == '' ||
                              controller.lastNameController.text == '') {
                            Fluttertoast.showToast(
                                msg: "enter_fullname".tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0.sp);
                          } else {
                            controller.apiUpdateUser();
                          }
                        },
                        child: Text(
                          "save".tr,
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
