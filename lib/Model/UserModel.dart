import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String name;
  final String email;
  final String? profileImage;
  final String? phone;
  final String gender;
  final DateTime dob;
  final Timestamp? createdAt;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    this.profileImage,
    this.phone,
    required this.gender,
    required this.dob,
    this.createdAt,
  });

  // Convert Firebase Document to UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profileImage: data['profileImage'] ?? '',
      phone: data['phone'] ?? '',
      gender: data['gender'] ?? '',
      dob: data['dob'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  // Convert UserModel to Map (for saving in Firebase)
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "profileImage": profileImage,
      "phone": phone,
      "gender": gender,
      "dob": dob,
      "createdAt": createdAt,
    };
  }
}
