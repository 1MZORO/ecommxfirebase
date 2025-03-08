import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomxfirebase/Model/ProductModel.dart';

class ProductService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addProduct(ProductModel product)async{
      try{
        await _firestore.collection('Products').add(product.toMap());
        log('Product added successfully');
        return true;
      }catch(e){
          return false;
      }
  }

  Future<List<ProductModel>> fetchProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('Products').get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromFirestore(doc);
    }).toList();
  }


  Future<bool> updateProduct(ProductModel product,String uid)async{
    try{
      await _firestore.collection('Products').doc(uid).update(product.toMap());
      log('Product added successfully');
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> deleteProduct(String uid)async{
    try{
      await _firestore.collection('Products').doc(uid).delete();
      log('Product deleted successfully');
      return true;
    }catch(e){
      return false;
    }
  }

}