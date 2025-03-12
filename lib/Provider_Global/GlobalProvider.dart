import 'dart:io';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier{

  List<File> _images = [];
  dynamic _value ;
  DateTime? _selectedDate;
  bool _validate = false;
  File? _singleImage;

  List<File> get images => _images ;
  dynamic get value => _value;
  DateTime? get selectedDate => _selectedDate;
  bool get validate => _validate;
  File? get singleImage => _singleImage;

  void setSingleImage(File img){
      _singleImage = img;
      notifyListeners();
  }
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

  void setValidate(bool value){
    _validate = value;
    notifyListeners();
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
  void clearSingleImages() {
    _singleImage = null;
    notifyListeners();
  }
  void clearValue(){
    _value = null;
    notifyListeners();
  }
}