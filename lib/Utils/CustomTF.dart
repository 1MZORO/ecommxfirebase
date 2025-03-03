import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTF extends StatelessWidget {
  final TextEditingController clt;
  final String txt;
  final bool obscureText;
  TextInputType? keyboardType;
  CustomTF({super.key, required this.clt, required this.txt ,required this.obscureText, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: clt,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: txt,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 18),
        fillColor: Colors.grey.shade200,
          filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
