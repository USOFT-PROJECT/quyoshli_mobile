import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quyoshli/models/main/power_model.dart';
import 'package:quyoshli/models/main/region_model.dart';

import '../models/main/services_model.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({
    super.key,
    required this.index,
    required this.options,
    required this.onChange,
    required this.label,
  });

  final int? index;
  final List options;
  final Function onChange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xFFF1F1F1),
      ),
      child: Row(
        children: [
          Expanded(
            child: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
              child: DropdownButtonFormField<int>(
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                menuMaxHeight: 300.h,
                alignment: Alignment.center,
                decoration: InputDecoration(
                  label: Text(
                    label,
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF474747),
                    ),
                  ),
                  border: InputBorder.none,
                ),
                isExpanded: true,
                value: index,
                items: List.generate(
                  options.length,
                  (index) {
                    String displayText = '';
                    if (options[index] is RegionModel) {
                      displayText = (options[index] as RegionModel).name ?? "";
                    } else if (options[index] is PowerModel) {
                      displayText =
                          (options[index] as PowerModel).power?.toString() ?? "";
                    } else if (options[index] is City) {
                      displayText = (options[index] as City).name ?? "";
                    } else if (options[index] is Problem) {
                      displayText = (options[index] as Problem).title ?? "";
                    }
                    return DropdownMenuItem(
                      value: index,
                      child: Text(
                        textScaler: TextScaler.linear(1),
                        displayText,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  },
                ),
                onChanged: (value) {
                  onChange(value);
                },
                icon: const Icon(null),
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
