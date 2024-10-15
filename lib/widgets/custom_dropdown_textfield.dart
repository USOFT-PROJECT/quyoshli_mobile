import 'package:flutter/material.dart';

class CustomDropdownTextField extends StatelessWidget {
  const CustomDropdownTextField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        // color: Colors.green,
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            labelText: label,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
          icon: const SizedBox.shrink(),
          isExpanded: true,
          dropdownColor: Colors.white,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                // color: Colors.white,
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
