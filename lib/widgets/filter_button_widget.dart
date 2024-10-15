import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    super.key,
    required this.textLeft,
    required this.textRight,
    required this.onChange,
    required this.chosen,
  });

  final bool chosen;
  final String textLeft;
  final String textRight;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //client
        Expanded(
          child: GestureDetector(
            onTap: () {
              onChange(true);
            },
            child: Container(
              alignment: Alignment.center,
              height: 48,
              decoration: BoxDecoration(
                color:
                    chosen ? AppColors.filterChosenColor : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                border:
                    Border.all(color: AppColors.filterBorderColor, width: 1),
              ),
              child: Text(
                textLeft,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),

        //master
        Expanded(
          child: GestureDetector(
            onTap: () {
              onChange(false);
            },
            child: Container(
              alignment: Alignment.center,
              height: 48,
              decoration: BoxDecoration(
                color:
                    !chosen ? AppColors.filterChosenColor : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                border:
                    Border.all(color: AppColors.filterBorderColor, width: 1),
              ),
              child: Text(
                textRight,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
