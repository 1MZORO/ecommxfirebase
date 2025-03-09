import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider_Global/GlobalProvider.dart';

class DropDown extends StatelessWidget {
  final String text;
  final List<String> items;
  DropDown({super.key, required this.items, required this.text});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButton<String>(
        value:  provider.value,
        hint: Text(text,style: TextStyle(color: Colors.grey),),
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
      ),
    );
  }
}
