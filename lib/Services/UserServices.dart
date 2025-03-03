import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomxfirebase/Services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  User? user;

  Future<void> addUserDetails(String fullname, gender ,dob,email,phoneNo) async {
    user = _authService.getCurrentUser();
    _firestore
        .collection('Users')
        .doc(user?.uid)
        .collection('User Details')
        .doc(user?.uid)
        .set({
      'fullName': fullname,
      'dob':dob,
      'email':email,
      'phoneNo':phoneNo,
      'gender':gender
    });
    log('Info Added Successfully');
  }

  Future<void> addAddress(String fullname, gender ,dob,email,phoneNo) async {
    user = _authService.getCurrentUser();
    _firestore
        .collection('Users')
        .doc(user?.uid)
        .collection('Address Details')
        .doc(user?.uid)
        .set({
      'fullName': fullname,
      'dob':dob,
      'email':email,
      'phoneNo':phoneNo,
      'gender':gender
    });
  }
}
