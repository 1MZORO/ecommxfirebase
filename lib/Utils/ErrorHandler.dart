import 'package:flutter/material.dart';

void errorHandler(BuildContext context, Function action) async {
  try {
    await action();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
