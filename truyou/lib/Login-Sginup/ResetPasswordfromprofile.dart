
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truyou/Login-Sginup/Errorpopup.dart';
import 'package:truyou/Login-Sginup/Sign_in.dart';

class ResetPassword_P extends StatefulWidget {
  final String email;
ResetPassword_P({required this.email});

  @override
  _ResetPassword createState() =>_ResetPassword();
}

class _ResetPassword extends State<ResetPassword_P> {
  TextEditingController emailController = TextEditingController();
late String email;
  @override
  void initState() {
      email=widget.email;
    super.initState();
   
  
   
  }
  // Function to build text fields for input
  Widget _buildTextField(String hintText, TextEditingController controller) {
  bool isEmailController = controller == emailController;
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
    ),
    enabled: !isEmailController,
  );
}
  // Show alert dialog
  void _showAlertDialog(String t, String message) {
     bool dialogOpen = true;

    // Show the dialog
    showDialog(
      context: context,
      builder: (context) => ErrorMessagePopup(
        title: t,
        description: message,
      ),
    ).then((_) {
      // When the dialog is dismissed manually, set dialogOpen to false
      dialogOpen = false;
    });

    // Dismiss the dialog automatically after 1.5 seconds
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      if (dialogOpen) {
        Navigator.of(context).pop(); // Dismiss the dialog only if still open
      }
    });
  }

 // Function to send a verification link to the email
Future<void> _sendVerificationLink() async {
 
  if (email.isEmpty) {
    _showAlertDialog('Not Valid', 'Please enter your email address.');
    return;
  }

  try {
    // Check if the email exists in the Firestore database
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // No user found with the given email
      _showAlertDialog('Not Valid', 'User does not exist.');
      return;
    }

    // Send the verification link using Firebase Authentication
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    _showAlertDialog('Success', 'Reset Password link sent to your email.');

    // Wait for 2 seconds before navigating to the next screen
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(context, _createPageRoute(LoginScreen()));

  } catch (e) {
    _showAlertDialog('Not Valid', 'Error: $e');
  }
}
 PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Image(image: AssetImage('images/brain.png')),
                    SizedBox(height: 10),
                    Text(
                      'TruYou',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF242C5B),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Mental health assistant',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Color(0x6B000000),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50), // Space between header and input fields
              _buildTextField(email, emailController),
              const SizedBox(height: 20),
              // Verify button
              ElevatedButton(
                onPressed: _sendVerificationLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA259FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: const Size(270, 48),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
          
            ],
          ),
        ),
      ),
    );
  }
}
