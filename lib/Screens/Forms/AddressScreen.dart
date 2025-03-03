import 'package:ecomxfirebase/Utils/CustomTF.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  final _houseNoClt = TextEditingController();
  final _localityClt = TextEditingController();
  final _cityClt = TextEditingController();
  final _stateClt = TextEditingController();
  final _zipCodeClt = TextEditingController();
  AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            CustomTF(clt: _localityClt , txt: 'Street no and area', obscureText: false),
            SizedBox(height: 20,),
            CustomTF(clt: _houseNoClt , txt: 'House no', obscureText: false),
            SizedBox(height: 20,),
            CustomTF(clt: _cityClt , txt: 'City', obscureText: false),
            SizedBox(height: 20,),
            CustomTF(clt: _stateClt , txt: 'State', obscureText: false),
            SizedBox(height: 20,),
            CustomTF(clt: _zipCodeClt , txt: 'Zip Code', obscureText: false),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              
            }, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
