import 'package:ecomxfirebase/Screens/Forms/AddressScreen.dart';
import 'package:ecomxfirebase/Screens/Forms/UserInfoScreen.dart';
import 'package:flutter/material.dart';
import '../Services/AuthServices.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            final authService = AuthService();
             await authService.logout();
          }, icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.person,size: 50,),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: ListView(
                children: [
                  _widget(size, 'User Information', (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>UserInfoScreen()));
                  }),

                  SizedBox(height: 20,),

                  _widget(size, 'Address', (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>AddressScreen()));
                  }),

                  SizedBox(height: 20,),

                  _widget(size, 'Log Out', ()async{
                    final authService = AuthService();
                    await authService.logout();
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _widget(Size size , String text ,Function()? onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: size.height*.08,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              Icon(Icons.arrow_forward_ios,size: 20,)
            ],
          )),
    );
  }
}
