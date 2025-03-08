import 'dart:io';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier{

  List<File> _images = [];
  dynamic _value ;
  DateTime? _selectedDate;

  List<File> get images => _images ;
  dynamic get value => _value;
  DateTime? get selectedDate => _selectedDate;

  void setImages(List<File> images){
      _images = images;
      notifyListeners();
  }

  void setValue(dynamic value){
    _value = value;
    notifyListeners();
  }

  void setDate(DateTime? selectedDate){
    _selectedDate = selectedDate;
    notifyListeners();
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}