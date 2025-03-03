import 'package:flutter/material.dart';
import '../../Utils/CustomTF.dart';
import '../../Utils/ShowSnackBar.dart';

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

                }, child: Text('Continue'))
              ]
              )

          ),
        ));
  }
}
