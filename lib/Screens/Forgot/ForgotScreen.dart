import 'package:ecomxfirebase/Screens/LoginScreen.dart';
import 'package:ecomxfirebase/Services/AuthServices.dart';
import 'package:ecomxfirebase/Utils/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import '../../Utils/CustomTF.dart';

class ForgotScreen extends StatelessWidget {
   ForgotScreen({super.key});

  final _emailClt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
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
                  padding: const EdgeInsets.only(top: 10, bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Forgot Password',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                CustomTF(
                  clt: _emailClt,
                  txt: "Email Address",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                ElevatedButton(onPressed: ()async{
                  final authService = AuthService();
                  authService.forgotPassword(_emailClt.text).then((value){
                    if(value){
                      showSnackBar(context, 'Reset Password Successfully Check Email');
                      Navigator.pop(context);
                    }else{
                      showSnackBar(context, 'Invalid Email or User');
                    }
                  });
                }, child: Text('Continue'))
              ]
              )

          ),
        ));
  }
}
