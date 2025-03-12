import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider_Global/GlobalProvider.dart';

class DropDown extends StatelessWidget {
  final String text;
  final List<String> items;

  const DropDown({super.key, required this.items, required this.text});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);

    // Ensure the value is either one of the items or null
    String? selectedValue = provider.value as String?;

    // Debugging: Print the selected value and the items
    print('Selected value: $selectedValue');
    print('Dropdown items: $items');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: items.contains(selectedValue) ? selectedValue : null, // Allow null
        hint: Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            provider.setValue(newValue);
            print('New value selected: $newValue');
          }
        },
      ),
    );
  }
}
