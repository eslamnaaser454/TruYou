import 'package:flutter/material.dart';
import 'package:truyou/Login-Sginup/Sign_Up.dart';
import 'package:truyou/welcomeScreens/welcomescreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    this.backgroundColor = const Color(0xFF9747FF), // Purple background color
    this.logoSize = 100.0, // Adjusted size for better visibility
  });

  final Color backgroundColor;
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    // Navigate to the login page after 3000ms
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(

          pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(),


          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Applying ease-in-out animation
            const begin = Offset(1.0, 0.0); // Start from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Image(
            image: const AssetImage('Assets/Logo/brain(White).png'),
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
            color: Colors.white, // White brain puzzle icon
          ),
        ),
      ),
    );
  }
}

// Dummy LoginPage for navigation demonstration
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Login Button'),
        ),
      ),
    );
  }
}

