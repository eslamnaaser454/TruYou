import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Brain icon
                Container(
                  width: screenWidth * 0.32,
                  height: screenWidth * 0.32,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Media/images/brainwelcome.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Welcome text
                const Text(
                  'Welcome to Truyou',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.28,
                    color: Color(0xFFA259FF),
                  ),
                ),
                const SizedBox(height: 10),
                // Description text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 46),
                  child: Text(
                    'The starting point for your journey\ntowards emotional well_being.Together lets\nexplore a holistic approach to\nmental health with truyou',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.14,
                      color: Color(0xB2C0B1E8),
                      height: 1.43,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Get Started button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cbt');
                    },
                    child: Container(
                      width: screenWidth * 0.75,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA259FF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
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
