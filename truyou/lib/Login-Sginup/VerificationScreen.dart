import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truyou/Login-Sginup/PasswordRecover.dart';
import 'package:truyou/Login-Sginup/Sign_in.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  VerificationScreen({required this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController codeController = TextEditingController();
  late String email;

  @override
  void initState() {
    super.initState();
    email = widget.email;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendVerificationLink(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    String maskedEmail = _maskEmail(email); // Mask the email

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Image(image: AssetImage('Assets/Logo/brain.png'), width: 100, height: 100),
                      SizedBox(height: 10),
                      Text(
                        'TruYou',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242C5B),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mental health assistant',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: Color(0x6B000000),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Verify Your Email',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA259FF),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
                  child: Column(
                    children: [
                      // Display the message with the masked email
                      Text(
                        'Verification Link sent to $maskedEmail',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF242C5B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 26),

                      // Submit button
                      Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFA259FF), Color(0xFF7933FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                          await   _checkVerificationStatus(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(270, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'VERIFY',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendVerificationLink(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        _showAlert(context, 'Verification Email Sent',
            'A verification link has been sent to your email. Please check your inbox.');
      } else {
        _showAlert(context, 'Action Not Needed',
            'No user is signed in or the email is already verified.');
      }
    } catch (e) {
      _showAlert(context, 'Error', 'An error occurred: $e');
    }
  }

  Future<void> _checkVerificationStatus(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reload the user to get the latest email verification status
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) { // Null-safe access to emailVerified
        // Update the 'isVerify' field in Firestore to true only if not already verified
        try {
          await FirebaseFirestore.instance
              .collection('users') // Replace with your actual collection name
              .doc(user!.uid) // Use the user's Firebase Authentication UID
              .update({'isVerify': true}); // Update the 'isVerify' field to true
          
          // Redirect to the password recovery page if the email is verified
          Navigator.push(context, _createPageRoute(LoginScreen()));
        } catch (e) {
          print('Error updating isVerify field: $e');
        }
      } else {
        // Show alert if the email is still not verified
        _showAlert(
          context,
          'Email not verified',
          'Please verify your email to proceed. Check your inbox for the verification email.',
        );
      }
    } else {
      _showAlert(context, 'No user signed in',
          'You need to sign in first before verifying your email.');
    }
  } catch (e) {
    _showAlert(
      context,
      'Error',
      'An error occurred while checking your email verification status: $e',
    );
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

  String _maskEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex <= 2) {
      return email[0] + '*' * (atIndex - 1) + email.substring(atIndex);
    }
    return email.substring(0, 2) + '*' * (atIndex - 2) + email.substring(atIndex);
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
    ),);}
}