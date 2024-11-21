import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Column(children: [
        Image(image: AssetImage('Assets/Logo/brain.png')),
        Text('Sign Up'),
      ]),
    ));
  }
}
