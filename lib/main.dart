import 'package:ecomxfirebase/Utils/ThemeDataClass.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Provider_Global/BottomProvider.dart';
import 'Provider_Global/GlobalProvider.dart';
import 'Services/AuthGate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // try {
  //   await Firebase.initializeApp(); // Ensure this is awaited
  // } catch (e) {
  //   print("Firebase Initialization Error: $e"); // Debugging
  // }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomProvider()),
        ChangeNotifierProvider(create: (context) => GlobalProvider())
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
