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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignupScreen()));
                    },
                    child: Text(
                      "Create one",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}