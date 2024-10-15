import 'package:flutter/cupertino.dart';
import 'package:quyoshli/core/app_colors.dart';

class CustomOutlinedButtonWidget extends StatelessWidget {
  const CustomOutlinedButtonWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.filterBorderColor),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.mainAppColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
