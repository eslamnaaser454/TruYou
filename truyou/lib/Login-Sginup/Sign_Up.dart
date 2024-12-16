import 'package:flutter/material.dart';
import 'package:truyou/Login-Sginup/Sign_in.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              // Logo and Title Section
              const Column(
                children: [
                  Image(
                    image: AssetImage('Assets/Logo/brain.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'TruYou',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF242C5B),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Mental health assistant',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Color(0x6B000000),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sign-up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFA259FF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              // Form Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.125),
                child: Column(
                  children: [
                    _buildTextField('Username'),
                    const SizedBox(height: 14),
                    _buildTextField('E-mail'),
                    const SizedBox(height: 14),
                    _buildTextField('Password'),
                    const SizedBox(height: 14),
                    _buildTextField('Mobile'),
                    const SizedBox(height: 26),
                    // Sign-up Button
                    Container(
                      width: screenWidth * 0.75,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFFA259FF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Sign-up',
                          style: TextStyle(
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
              SizedBox(height: screenHeight * 0.05),
              // Login Link
              Padding(
                padding: const EdgeInsets.only(bottom: 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC0B1E8),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
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
    );
  }

  Widget _buildTextField(String placeholder) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Color(0xFFF8F5FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xB2C0B1E8),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
