import 'package:flutter/material.dart';
// import 'package:truyou/Login-Sginup/Sign_Up.dart';
// import 'package:truyou/Login-Sginup/Sign_in.dart';
// import 'package:truyou/screens/Sign_in.dart';
import 'package:truyou/Login-Sginup/SplashScreen.dart';
import 'package:truyou/Login-Sginup/recoveryquestion.dart';

void main() {
  runApp(const TruYouApp());
}

class TruYouApp extends StatelessWidget {
  const TruYouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: SplashScreen(), // Wraps the SignUp widget in MaterialApp
    );
  }
}
