import 'package:flutter/material.dart';
// import '../Services/GetUserData.dart';

class UserDataProvider with ChangeNotifier {
  // FirebaseService _firebaseService = FirebaseService();
  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  Future<void> fetchUserData(String userId) async {
    try {
      // var userDoc = await _firebaseService.getUserData(userId);
      // _userData = userDoc.data() as Map<String, dynamic>;
      notifyListeners(); // Notify listeners when data is updated
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
