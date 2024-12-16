import 'package:flutter/material.dart';

class RecoveryQuestion extends StatelessWidget {
final VoidCallback? onConfirm;
final VoidCallback? onLogin;
final Function(String)? onQuestionSelect;
final Function(String)? onAnswerChange;

const RecoveryQuestion({
    super.key,
    this.onConfirm,
    this.onLogin,
    this.onQuestionSelect,
    this.onAnswerChange,
});

@override
Widget build(BuildContext context) {
    return Scaffold(
    body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth * 0.75; // 75% of screen width

        return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            ),
            child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo and Title
                const SizedBox(height: 58),
                const Image(
                    image: AssetImage('Assets/Logo/brain.png'),
                ),
                const Text(
                    'TruYou',
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    ),
                ),
                const Text(
                    'Mental health assistant',
                    style: TextStyle(
                    color: Color(0x6B000000),
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    ),
                ),

                const SizedBox(height: 69),
                const Text(
                    'Recovery question',
                    style: TextStyle(
                    color: Color(0xFFA259FF),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    ),
                ),

                const SizedBox(height: 26),
                  // Question Dropdown
                Container(
                    width: width,
                    height: 48,
                    decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                            'Choose Question',
                            style: TextStyle(
                            color: Color(0xFFA259FF),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                            ),
                        ),
                        Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFFA259FF),
                        ),
                        ],
                    ),
                    ),
                ),
                const SizedBox(height: 13),
                  // Answer Input
                Container(
                    width: width,
                    height: 48,
                    decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Question Answer',
                        hintStyle: TextStyle(
                            color: Color(0xB2C0B1E8),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                        ),
                        ),
                        onChanged: onAnswerChange,
                    ),
                    ),
                ),

                const SizedBox(height: 20),
                  // Confirm Button
                GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                    width: width,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Color(0xFFA259FF),
                        borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Inter',
                        ),
                        ),
                    ),
                    ),
                ),

                const Spacer(),
                  // Login Link
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                        'Already have an account? ',
                        style: TextStyle(
                        color: const Color(0xFFC0B1E8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        ),
                    ),
                    GestureDetector(
                        onTap: onLogin,
                        child: Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFFA259FF),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                        ),
                        ),
                    ),
                    ],
                ),
                const SizedBox(height: 16),
                ],
            ),
            ),
        );
        },
    ),
    );
}
}
