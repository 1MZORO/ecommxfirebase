import 'dart:developer';

import 'package:flutter/material.dart';
import '../Services/AuthServices.dart';
import '../Utils/CustomTF.dart';
import 'LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailClt = TextEditingController();
  final TextEditingController _passClt = TextEditingController();
  final TextEditingController _usernameClt = TextEditingController();
  final TextEditingController _fullnameClt = TextEditingController();

  @override
  void dispose() {
    _emailClt.dispose();
    _passClt.dispose();
    _fullnameClt.dispose();
    _usernameClt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                CustomTF(
                  clt: _fullnameClt,
                  txt: "full name",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                // CustomTF(
                //   clt: _usernameClt,
                //   txt: "phone no",
                //   obscureText: false,
                //   keyboardType: TextInputType.number,
                // ),
                // SizedBox(
                //   height: size.height * .01,
                // ),
                CustomTF(
                  clt: _emailClt,
                  txt: "email",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _passClt,
                  txt: "password",
                  obscureText: true,
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                ElevatedButton(
                    onPressed: () async{
                      final authService = AuthService();
                      final res = await authService.signUpWthEmail(_emailClt.text, _passClt.text);
                      _emailClt.clear();
                      _passClt.clear();
                      _fullnameClt.clear();
                      log(res.toString());
                    },
                    child: Text("Continue")),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have account "),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
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
