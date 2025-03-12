import 'package:ecomxfirebase/Provider_Global/UserDataProvider.dart';
import 'package:ecomxfirebase/Services/AuthGate.dart';
import 'package:ecomxfirebase/Utils/ThemeDataClass.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Provider_Global/BottomProvider.dart';
import 'Provider_Global/GlobalProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomProvider()),
        ChangeNotifierProvider(create: (context) => GlobalProvider()),
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: clotTheme,
      home: const AuthGate(),
    );
  }
}
