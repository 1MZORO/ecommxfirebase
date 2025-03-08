import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider_Global/GlobalProvider.dart';

class DropDown extends StatelessWidget {
  String? selectedValue;
  final List<String> items;
  DropDown({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return DropdownButton<String>(
      value:  provider.value,
      hint: Text("Select an Item"),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
             provider.setValue(newValue);
             print('$newValue & ${provider.value}');
      },
    );
  }
}
