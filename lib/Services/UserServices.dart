import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomxfirebase/Model/UserModel.dart';
import 'package:ecomxfirebase/Services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  User? user;

  Future<bool> addUserDetails(UserModel userModel) async {
    user = _authService.getCurrentUser();
    try{
      await _firestore
          .collection('Users')
          .doc(user?.uid)
          .set(userModel.toMap());
      print(userModel.toMap());
      log('Info Added Successfully');
      return true;
    }catch(e){
      log(e.toString());
      return false;
    }
  }

  Future<void> addAddress(UserModel userModel) async {
    user = _authService.getCurrentUser();
    _firestore
        .collection('Users')
        .doc(user?.uid)
        .set(userModel.toMap());
  }
}
