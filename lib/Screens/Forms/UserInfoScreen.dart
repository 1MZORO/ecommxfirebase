import 'package:ecomxfirebase/Services/UserServices.dart';
import 'package:ecomxfirebase/Utils/CustomTF.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  final _fullNameClt = TextEditingController();
  final _emailClt = TextEditingController();
  final _phone = TextEditingController();
  final _dob = TextEditingController();
  final _gender = TextEditingController();
  UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.shade200),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Add Address',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              CustomTF(clt: _fullNameClt , txt: 'Full Name', obscureText: false),
              SizedBox(height: 20,),
              CustomTF(clt: _emailClt , txt: 'Email', obscureText: false),
              SizedBox(height: 20,),
              CustomTF(clt: _phone , txt: 'Phone no', obscureText: false),
              SizedBox(height: 20,),
              CustomTF(clt: _dob , txt: 'D O B', obscureText: false),
              SizedBox(height: 20,),
              CustomTF(clt: _gender , txt: 'Gender', obscureText: false),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                UserServices userServices = UserServices();
                // userServices.addUserDetails(_fullNameClt.text, _emailClt.text, _phone.text, _dob.text, _gender.text);
              }, child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
