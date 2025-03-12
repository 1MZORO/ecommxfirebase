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

  Future<UserModel> fetchUserDetails(String id) async {
    DocumentSnapshot<Map<String, dynamic>> userDetails = await _firestore.collection('Users').doc(id).get();

    if(userDetails.exists){
      return UserModel.fromFirestore(userDetails);
    }else{
      throw Exception("User data not found ");
    }
  }

Future<bool> addProfileImage(String url) async {
  try {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log("No user is currently logged in");
      return false;
    }
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .update({'profileImage': url});

    return true;
  } catch (e) {
    log("Error updating profile image: ${e.toString()}");
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
