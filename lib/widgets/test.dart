import 'package:flutter/material.dart';
import 'package:quyoshli/core/app_colors.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: 1,
              items: List.generate(
                8,
                (index) =>
                    DropdownMenuItem(value: index, child: Text("$index")),
              ),
              onChanged: (value) {},
            ),
            SizedBox(
              height: 40,
            ),
            DropdownAboveButton(),
            SizedBox(
              height: 40,
            ),
            DropdownAboveButton(),
          ],
        ),
      ),
    );
  }
}

class DropdownAboveButton extends StatefulWidget {
  @override
  _DropdownAboveButtonState createState() => _DropdownAboveButtonState();
}

class _DropdownAboveButtonState extends State<DropdownAboveButton> {
  String? selectedValue;
  List<String> items = [
    'Андижанская область',
    'Бухарская область',
    'Джизакская область',
    'Каракалпакстан',
    'Кашкадарьинская область',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: DropdownButtonFormField<String>(
        borderRadius: BorderRadius.circular(10),

        value: selectedValue,
        style: const TextStyle(color: Colors.black),
        selectedItemBuilder: (context) =>
            [DropdownMenuItem(child: Text("ehllo"))],
        decoration: InputDecoration(
            label: Text('Область'),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: const TextStyle(
                fontSize: 12, color: AppColors.textFieldLabelColor),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black))),

        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },

        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
        // To make the dropdown open upwards
        dropdownColor: Colors.white,
        elevation: 4,

        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
      ),
    );
  }
}
