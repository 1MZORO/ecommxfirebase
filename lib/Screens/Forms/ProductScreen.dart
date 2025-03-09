import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomxfirebase/ApiCalls/Cloudinary.dart';
import 'package:ecomxfirebase/Model/ProductModel.dart';
import 'package:ecomxfirebase/Provider_Global/GlobalProvider.dart';
import 'package:ecomxfirebase/Services/ProductService.dart';
import 'package:ecomxfirebase/Utils/DropDown.dart';
import 'package:ecomxfirebase/Utils/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameClt = TextEditingController();
  final _descriptionClt = TextEditingController();
  final _priceClt = TextEditingController();
  final _brandClt = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);

    Future<void> _pickImages() async {
      final pickedFiles = await ImagePicker().pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        List<File> images = pickedFiles.map((e) => File(e.path)).toList();

        log("Picked Images: $images");

        provider.setImages(images);
      } else {
        log("No images selected");
      }
    }

    void clean(){
      _nameClt.clear();
      _brandClt.clear();
      _priceClt.clear();
      _descriptionClt.clear();
      provider.clearImages();
    }
    
    Widget _buildTextField(TextEditingController controller, String hint,
        {TextInputType type = TextInputType.text}){
      return TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          fillColor: Colors.grey.shade200,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Field cannot be empty' : null,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_nameClt, 'Product Name'),
              SizedBox(height: 10),
              _buildTextField(_descriptionClt, 'Description'),
              SizedBox(height: 10),
              _buildTextField(_priceClt, 'Price in RS',type: TextInputType.number),
              SizedBox(height: 10),
              _buildTextField(_brandClt, 'Brand Name'),
              SizedBox(height: 10),
              DropDown(items: ['Shoes','Hoodies'], text: 'Select Category',),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.image),
                label: Text('Pick Images'),
                onPressed: _pickImages,
              ),
              provider.images.isNotEmpty
                  ? Wrap(
                      children: provider.images.map((img) {
                        return Padding(
                          padding: EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(img,
                                width: 80, height: 80, fit: BoxFit.cover),
                          ),
                        );
                      }).toList(),
                    )
                  : Text('No images selected'),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final cloudinary = Cloudinary();
                        final productService = ProductService();
                        List<String> urls =
                            await cloudinary.uploadImages(provider.images);

                        if (urls.isNotEmpty) {
                          final productModel = ProductModel(
                              name: _nameClt.text,
                              description: _descriptionClt.text,
                              price: _priceClt.text,
                              imageUrls: urls,
                              createdAt: Timestamp.now(),
                              brand: _brandClt.text,
                              category: provider.value);
                          productService.addProduct(productModel).then((value){
                            if(value){
                                clean();
                                showSnackBar(context, 'Product Added Successfully');
                            }else{
                              showSnackBar(context, 'Failed while creating Product');
                            }
                          });
                        }
                      },
                      child: Text('Upload Product'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameClt.dispose();
    _brandClt.dispose();
    _priceClt.dispose();
    _descriptionClt.dispose();
    super.dispose();
  }
}