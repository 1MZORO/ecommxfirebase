import 'dart:developer';
import 'package:ecomxfirebase/Services/AuthServices.dart';
import 'package:ecomxfirebase/Utils/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import '../Utils/CustomTF.dart';
import 'Forgot/ForgotScreen.dart';
import 'SignupScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailClt = TextEditingController();
  final TextEditingController _passClt = TextEditingController();
  final authService = AuthService();

  @override
  void dispose() {
    _emailClt.dispose();
    _passClt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sign in',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
              ),
              CustomTF(clt: _emailClt, txt: "Email Address", obscureText: false,),
              SizedBox(
                height: size.height * .01,
              ),
              CustomTF(clt: _passClt, txt: "Password", obscureText: true,),
              SizedBox(
                height: size.height * .01,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgotScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot password?'),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              ElevatedButton(
                onPressed: () async{
                  try{
                    if(_emailClt.text.toString() == "admin@gmail.com"){
                      await authService.signInWthEmailAsAdmin(_emailClt.text, _passClt.text).then((value){
                        log("Admin Login");
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      });
                    }else{
                      await authService.signInWthEmail(_emailClt.text, _passClt.text);
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));/
                    }
                  }catch(e){
                    log(e.toString());
                    showSnackBar(context, "Error while login");
                  }

                },
                child: Text("Continue"),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Don't have account? "),
                  // SizedBox(height: 10,),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => SignupScreen()));
                        });
                      },
                      child: Text(
                        "Create one",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              // Row(
              //   children: [
              //     IconButton(onPressed: () {
              //       final res = authService.signInWithGoogle();
              //       log('$res created');
              //     },
              //     icon: Icon(Icons.login))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}