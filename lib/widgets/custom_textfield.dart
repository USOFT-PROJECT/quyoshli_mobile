import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quyoshli/services/utils_service.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.textEditingController,
    this.formatter,
    this.type,
    this.onChange,
    this.enabled,
    this.maxLength,
    this.capitalization,
    this.errorText,
    this.isValid,
    this.maxLines,
  });

  final Function? onChange;
  final TextInputType? type;
  final MaskTextInputFormatter? formatter;
  final TextEditingController? textEditingController;
  final String label;
  final bool? enabled;
  final int? maxLength;
  final TextCapitalization? capitalization;
  final String? errorText;
  final bool? isValid;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(1),
          ),
          child: TextField(
            onChanged: (value) {
              if (onChange != null) {
                onChange!(value);
              }
            },
            maxLines: maxLines,
            inputFormatters: formatter != null ? [formatter!] : null,
            textCapitalization: capitalization != null
                ? capitalization!
                : TextCapitalization.none,
            controller: textEditingController,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            // maxLines: null,
            textInputAction: TextInputAction.done,
            keyboardType: type,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.zero,
              isDense: true,
              label: Text(
                isValid != null
                    ? isValid!
                        ? label
                        : errorText!
                    : label,
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isValid == null
                      ? const Color.fromRGBO(71, 71, 71, 1)
                      : isValid!
                          ? const Color.fromRGBO(71, 71, 71, 1)
                          : Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),
              border: InputBorder.none,
            ),
            enabled: enabled,
            maxLength: maxLength,
          ),
        ),
      ),
    );
  }
}
