import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomxfirebase/Utils/ShowSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<bool> signInWthEmail(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      log('Error while login $e');
      return false;
    }
  }

  Future<bool> signInWthEmailAsAdmin(String email, password) async {
    try {
      if (email == "admin@gmail.com") {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      log('Error while login $e');
      return false;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
          credential);
      return userCredential.user;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }}


    Future<bool> signUpWthEmail(String email, password,
        BuildContext context) async {
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseAuth.instance.currentUser?.reload();
        _firestore.collection('Users').doc(userCredential.user?.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
        return true;
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, "$e");
        return false;
      }
    }

    Future<void> logout() async {
      return await _auth.signOut();
    }

    Future<bool> forgotPassword(String email) async {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        return true;
      } on FirebaseAuthException catch (e) {
        log('Error while login $e');
        return false;
      }
    }
  }