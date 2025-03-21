import 'dart:developer';
import 'package:ecomxfirebase/Screens/Auth/LoginScreen.dart';
import 'package:ecomxfirebase/Screens/Auth/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/MainScreen/BottomTabs.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          log('Stream Called ${snapshot.data?.email}');
          return BottomNavTabs(); // User is logged in
        } else {
          return SignupScreen(); // User is not logged in
        }
      },
    );
  }
}