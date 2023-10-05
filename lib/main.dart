import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_firebase/Activity/HomePage.dart';
import 'package:quiz_app_firebase/Activity/SigninPage.dart';
import 'package:quiz_app_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Firebase',
      home: LoginPage(),
    ),
  );
}
