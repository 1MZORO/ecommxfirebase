import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomxfirebase/Model/UserModel.dart';
import 'package:ecomxfirebase/Provider_Global/GlobalProvider.dart';
import 'package:ecomxfirebase/Services/UserServices.dart';
import 'package:ecomxfirebase/Utils/DropDown.dart';
import 'package:ecomxfirebase/Utils/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/AuthServices.dart';
import '../../Utils/CustomTF.dart';
import '../MainScreen/BottomTabs.dart';
import 'LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailClt = TextEditingController();
  final TextEditingController _passClt = TextEditingController();
  final TextEditingController _phonenoClt = TextEditingController();
  final TextEditingController _fullnameClt = TextEditingController();
  @override
  void dispose() {
    _emailClt.dispose();
    _passClt.dispose();
    _fullnameClt.dispose();
    _phonenoClt.dispose();
    super.dispose();
  }

  void clean() {
    _emailClt.clear();
    _passClt.clear();
    _fullnameClt.clear();
    _phonenoClt.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    var size = MediaQuery.of(context).size;

    Future<void> _pickDate(BuildContext context) async {
      log('message');
      DateTime now = DateTime.now();
      DateTime firstDate = DateTime(now.year - 80); // 5 years back
      DateTime lastDate = DateTime(now.year + 25); // 5 years ahead

      final pickedDate = await showDatePicker(
        context: context,
        initialDate: provider.selectedDate ?? now,
        firstDate: firstDate,
        lastDate: lastDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly, // Calendar mode
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(), // Customize theme if needed
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        provider.setDate(pickedDate);
      }
      log('$pickedDate & ${provider.selectedDate}');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
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
                      Text('Create Account',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTF(
                  clt: _fullnameClt,
                  txt: "Full Name",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _phonenoClt,
                  txt: "Phone No",
                  keyboardType: TextInputType.number,
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pick D.O.B',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () => _pickDate(context),
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                DropDown(
                  items: ['Male', 'Female', 'Other\'s'],
                  text: 'Select Gender',
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _emailClt,
                  txt: "Email",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _passClt,
                  txt: "Password",
                  obscureText: true,
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final authService = AuthService();
                      final userService = UserServices();
                      await authService
                          .signUpWthEmail(
                              _emailClt.text, _passClt.text, context)
                          .then((value) {
                            if(value){
                              showSnackBar(context, 'Signup Successfully');
                              final createUser = UserModel(
                                  name: _fullnameClt.text,
                                  email: _emailClt.text,
                                  gender: provider.value,
                                  dob: provider.selectedDate!,
                                  phone: _phonenoClt.text,
                                  createdAt: Timestamp.now());
                                  userService.addUserDetails(createUser).then((onValue){
                                    if(onValue){
                                      log('user added in fireStore');
                                    }
                                  });
                            }
                      });
                      clean();
                    },
                    child: Text("Continue")),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have account? "),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          });
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
