import 'package:flutter/material.dart';
import '../../Utils/CustomTF.dart';
import '../../Utils/ShowSnackBar.dart';

class ResetPasswordScreen extends StatelessWidget {
  final email;
  final _newPasswordClt = TextEditingController();
  final _confirmPasswordClt = TextEditingController();
  ResetPasswordScreen({super.key,required this.email});
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
                      Text('Reset Password',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                CustomTF(
                  clt: _newPasswordClt,
                  txt: "Enter new Password ",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _confirmPasswordClt,
                  txt: "Enter confirm Password ",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                ElevatedButton(onPressed: ()async{

                }, child: Text('Finish'))
              ]
              )

          ),
        ));
  }
}
