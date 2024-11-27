import 'package:flutter/material.dart';
// import 'package:truyou/screens/Sign_in.dart';
import 'package:truyou/Login-Sginup/Sign_up.dart';

void main() {
  runApp(const TruYouApp());
}

class TruYouApp extends StatelessWidget {
  const TruYouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: SignUp(), // Wraps the SignUp widget in MaterialApp
    );
  }
}
