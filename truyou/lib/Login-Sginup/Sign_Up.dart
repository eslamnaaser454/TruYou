import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:truyou/Login-Sginup/Sign_in.dart';

import 'package:truyou/Login-Sginup/VerificationScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  bool isPasswordVisible = false; // State variable for password visibility

  @override
  Widget build(BuildContext context) {
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
                      SizedBox(height: 10),
                      Text(
                        'Sign-up',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
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
                      _buildTextField('Username', usernameController),
                      const SizedBox(height: 14),
                      _buildTextField('E-mail', emailController),
                      const SizedBox(height: 14),
                      _buildPasswordField('Password', passwordController),
                      const SizedBox(height: 14),
                      _buildTextField('Mobile', mobileController),
                      const SizedBox(height: 26),
                      _buildSignUpButton(context),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC0B1E8),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, _createPageRoute(LoginScreen()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA259FF),
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

  // Function to build text fields for input
  Widget _buildTextField(String placeholder, TextEditingController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xB2C0B1E8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  // Password field with visibility toggle
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
                  fontFamily: 'Urbanist',
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

  // Sign-up button logic
  Widget _buildSignUpButton(BuildContext context) {
    return Container(
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
          // Check if email, phone, or username already exist
          bool emailExists = await _checkIfExists('email', emailController.text);
          bool phoneExists = await _checkIfExists('phone', mobileController.text);
          bool usernameExists = await _checkIfExists('username', usernameController.text);
         String phoneNumber = mobileController.text.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters
          if(usernameController.text.isEmpty){
  _showAlert(context, 'User Name Can\'t be empty');
            return;

          }
          if(emailController.text.length>320){
  _showAlert(context, 'Email is not Valid');
            return;


          }
          // Check if phone number contains less than 8 digits
          if (phoneNumber.length < 8||phoneNumber.length>20) {
            _showAlert(context, 'Invalid phone number');
            return;
          }
          if (emailExists) {
            _showAlert(context, 'Email is already registered.');
            return;
          }
  // Validate phone number (only digits or '+' allowed)
bool _validatePhoneNumber(String phoneNumber) {

  // Ensure phone number starts with "+" or digits only and contains no other characters
  final regex = RegExp(r'^[+]?[0-9]+$');
  return regex.hasMatch(phoneNumber) && phoneNumber.length >= 8;
}
  if(_validatePhoneNumber(mobileController.text)==false){

      _showAlert(context, 'Invalid phone number');
            return;
  }
          if (phoneExists) {
            _showAlert(context, 'Phone number is already registered.');
            return;
          }

          if (usernameExists) {
            _showAlert(context, 'Username is already taken.');
            return;
          }
          
          // If no conflicts, proceed with user registration
          try {
            UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

          // Save user data in Firestore
await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
  'username': usernameController.text,
  'email': emailController.text,
  'phone': mobileController.text,
  'uid': credential.user!.uid,
  'isVerify': false, // Add this field with a default value of false
});

            // Navigate to next screen
            Navigator.push(context, _createPageRoute( VerificationScreen( email: emailController.text)));
          } on FirebaseAuthException catch (e) {
            _showAlert(context, 'An error occurred: ${e.message}');
          } catch (e) {
            _showAlert(context, 'An unexpected error occurred.');
          }
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
          'Sign-up',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Function to check if a field (email, phone, username) already exists in Firestore
  Future<bool> _checkIfExists(String field, String value) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where(field, isEqualTo: value)
        .get();
    return result.docs.isNotEmpty;
  }

  // Show alert dialog
  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Page transition animation
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
