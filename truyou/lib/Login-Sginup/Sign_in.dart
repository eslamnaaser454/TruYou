import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Column(children: [
        Image(image: AssetImage('Assets/Logo/brain.png')),
        Text('TruYou', style: TextStyle(fontSize: 30)),
      ]),
    ));
  }
}
