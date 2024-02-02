import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productlisting/screens/home/home_screen.dart';
import 'package:productlisting/screens/logIn.dart';
import 'package:productlisting/screens/signUp.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Login(),
    );
  }
}
