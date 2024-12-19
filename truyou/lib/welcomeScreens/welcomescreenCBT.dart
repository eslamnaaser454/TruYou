import 'package:flutter/material.dart';

class Welcomescreencbt extends StatelessWidget {
  const Welcomescreencbt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: const Color(0xFFA259FF),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Texts
                const Text(
                  'CBT-Trainer',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Make TruYou your new Trainer',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    letterSpacing: -0.16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // Brain image with circle
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.55, // Decreased size
                      height: screenWidth * 0.55, // Decreased size
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF3EEFF)
                            .withOpacity(0.2), // Adjusted opacity
                      ),
                    ),
                    Image.asset(
                      'Media/images/welcomecbt.png',
                      width: screenWidth * 0.5, // Decreased size
                      height: screenWidth * 0.5, // Decreased size
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Dots indicator
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chatbotwelcome');
                    },
                    child: Container(
                      width: screenWidth * 0.75,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA259FF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
