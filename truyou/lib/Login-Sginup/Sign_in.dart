import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:truyou/Login-Sginup/PasswordRecover.dart';
import 'package:truyou/Login-Sginup/ResetPassword.dart';
import 'package:truyou/Login-Sginup/Sign_Up.dart';
import 'package:truyou/Login-Sginup/VerificationScreen.dart';
import 'package:truyou/profile/profilepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}
class _LoginScreen extends State<LoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false; // State variable for password visibility

  @override
  Widget build(BuildContext context) {
    bool rememberMe = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 71),
                  // Logo and Title Section
                  const Column(
                    children: [
                      Image(
                        image: AssetImage('images/brain.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'TruYou',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Mental health assistant',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: Color(0x6B000000),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Sign-in',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA259FF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Input Fields
                  Column(
                    children: [
                      _buildTextField('Email', usernameController),
                      const SizedBox(height: 15),
                      _buildPasswordField('Password', passwordController),
                      const SizedBox(height: 15),
                      // Remember Me
                      Row(
                        children: [
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                fillColor: WidgetStateProperty.all(const Color(0xFFA259FF)),
                              );
                            },
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xB2C0B1E8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Sign In Button
                      ElevatedButton(
                                   onPressed: () async {
  try {
    // Attempt to sign in with Firebase Authentication
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: usernameController.text,
      password: passwordController.text,
    );

    // If successful, navigate to the Home Page
    
    // Now, check if the email is verified from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users') // Your Firestore collection name
        .doc(userCredential.user!.uid) // Get the user's UID from Firebase Auth
        .get();

    if (userDoc.exists) {
      // Check the 'isVerify' field in Firestore
      bool isVerified = userDoc['isVerify'] ?? false;

      if (isVerified) {
        // If the user is verified, navigate to the HomePage
       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage(email:usernameController.text)), // Replace HomePage with your actual home widget
    );
      } else {
        // If the user is not verified, navigate to the KIP page
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerificationScreen(email:usernameController.text)), // Replace HomePage with your actual home widget
    );
      }
    } 

   
  } catch (e) {
    // Show an alert if there is an error (e.g., wrong credentials)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("The email or password you entered is incorrect."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA259FF),
                          minimumSize: const Size(270, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Forget Password
                      TextButton(
                        onPressed: () {

 Navigator.push(context, _createPageRoute( ResetPassword()));

                        },
                        child: const Text(
                          'Forget password ?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFC0B1E8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                      // Sign Up Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFC0B1E8),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // navigate to sign up page (sign-up button)
                              Navigator.push(context, _createPageRoute( SignUpScreen()));
                            },
                            child: const Text(
                              'Sign-up',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFA259FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String placeholder, TextEditingController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
         
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xB2C0B1E8),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPasswordField(String placeholder, TextEditingController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: !isPasswordVisible, // Toggle obscureText
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xB2C0B1E8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xB2C0B1E8),
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ],
      ),
    );
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
}
