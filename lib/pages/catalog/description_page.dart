import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DescriptionPage extends StatefulWidget {
  final String? description;
  const DescriptionPage({super.key, this.description});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  String description = '';

  @override
  void initState() {
    description = widget.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "product_description".tr,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Html(
                data: description,
                style: {
                  "html": Style(
                    fontSize: FontSize(16.sp),
                    fontWeight: FontWeight.w400,
                    margin: Margins.zero, // Remove default margin
                    padding: HtmlPaddings.zero, // Remove default padding if any
                  ),
                  "body": Style(
                    margin: Margins.zero, // Remove margin for <body> tag
                  ),
                  "p": Style(
                    margin: Margins.zero, // Remove margin for <p> tags
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
