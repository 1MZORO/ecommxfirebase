import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String name;
  final String description;
  final String price;
  final List<String> imageUrls;
  final String category;
  final Timestamp? createdAt;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.category,
    this.createdAt,
  });

  // Convert Firebase Document to ProductModel
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      category: data['category'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  // Convert ProductModel to Map (for saving in Firebase)
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "imageUrls": imageUrls,
      "category": category,
      "createdAt": createdAt,
    };
  }
}
