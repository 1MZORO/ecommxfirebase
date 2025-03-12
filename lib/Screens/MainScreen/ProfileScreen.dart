import 'dart:developer';
import 'dart:io';
import 'package:ecomxfirebase/ApiCalls/Cloudinary.dart';
import 'package:ecomxfirebase/Provider_Global/GlobalProvider.dart';
import 'package:ecomxfirebase/Screens/Auth/LoginScreen.dart';
import 'package:ecomxfirebase/Screens/Forms/AddressScreen.dart';
import 'package:ecomxfirebase/Screens/Forms/ProductScreen.dart';
import 'package:ecomxfirebase/Screens/Forms/UserInfoScreen.dart';
import 'package:ecomxfirebase/Services/UserServices.dart';
import 'package:ecomxfirebase/Utils/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../Services/AuthServices.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = AuthService().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    final size = MediaQuery.of(context).size;

    Future<bool> upload()async{
      try{
        final cloudinary = Cloudinary();
        final userService = UserServices();
        final url = await cloudinary.uploadImages(provider.images);
        if(url.isEmpty){
          log('Error :: while uploading profile image in cloudinary');
          provider.setValidate(false);
          return false;
        }
        await userService.addProfileImage(url[0]).then((value){
          if(value){
            log('Profile image updated');
            provider.setValidate(false);
          }
        });
        provider.setValidate(false);
        return true;
      }catch(e){
        log(e.toString());
        provider.setValidate(false);
        return false;
      }
    }

    void pickImage()async{
      try{
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          log(image.path);
          provider.setValue(image);
          provider.setValidate(true);
        } else {
          log('No image selected');
        }
      }catch(e){
      log(e.toString());
      }
    }

    return Scaffold(
      body: Stack(
        children:[
          provider.validate ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20,top: 10),
                child: GestureDetector(
                  onTap: () async{
                    await upload().then((value){
                      showSnackBar(context, 'Image Saved Successfully');
                    });
                  },
                  child: Text('Save',style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.w800),),
                ),
              )
            ],
          ) : Container(),
          Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 107,
                width: 107,
                child: Stack(children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: provider.value != null
                        ? FileImage(File(provider.value.path))
                        : null,
                    child:  provider.value != null ? null :Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  Positioned(
                    right: 0,
                      bottom: 0,
                      child: IconButton(onPressed: () {
                        pickImage();
                      }, icon: Icon(Icons.add_a_photo,color: Colors.grey,size: 16,)))
                ]),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView(
                  children: [
                    _widget(size, 'User Information', () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => UserInfoScreen()));
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    _widget(size, 'Address', () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AddressScreen()));
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    if (user?.email == "admin@gmail.com")
                      _widget(size, 'Add Product', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateProductScreen()));
                      }),
                    SizedBox(
                      height: 20,
                    ),
                    _widget(size, 'Log Out', () async {
                      final authService = AuthService();
                      await authService.logout().then((value) {
                        if (!value) {
                          final user = authService.getCurrentUser();
                          log(user!.email.toString());
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        }
                      });
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }

  Widget _widget(Size size, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: size.height * .08,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )
            ],
          )),
    );
  }
}
