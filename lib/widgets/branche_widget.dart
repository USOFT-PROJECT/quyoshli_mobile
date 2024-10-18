import 'package:flutter/material.dart';
import 'package:quyoshli/core/app_colors.dart';

import '../models/cart/branch_model.dart';

class BranchWidget extends StatelessWidget {
  const BranchWidget(
      {super.key,
      required this.branches,
      required this.itemIndex,
      required this.onChange});

  final List<BranchModel> branches;
  final int? itemIndex;
  final Function(int index) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        branches.length,
        (index) => GestureDetector(
          onTap: () {
            onChange(index);
          },
          child: Container(
            // height: 92,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                color: itemIndex == index
                    ? const Color(0xFFCBFAFC)
                    : const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(12),
                border: itemIndex == index
                    ? Border.all(color: const Color(0xFF006266), width: 2)
                    : Border.all(color: Colors.transparent, width: 2)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio<int>(
                  value: index,
                  groupValue: itemIndex,
                  onChanged: (int? value) {
                    onChange(value!);
                  },
                  activeColor: const Color(0xFF01A2A8),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        branches[index].address ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.textColor,
                        ),
                      ),
                      Text(branches[index].name ?? "")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
