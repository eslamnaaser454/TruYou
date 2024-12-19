import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage("Media/icons/previous.png")),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: const Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF393939),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Brain Logo
                    Image.asset(
                      'Media/images/brain.png',
                      width: 107,
                      height: 107,
                    ),
                    const SizedBox(height: 20),
                    // TruYou Text
                    const Text(
                      'TruYou',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA259FF),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Subtitle
                    const Text(
                      'Your Mental Health'
                      '\n'
                      'Assistant All Day',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color(0x6B000000),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Version Container
                    Container(
                      width: 55,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: const Color(0xFFA259FF),
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Ver 1.0',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA259FF),
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
    );
  }
}
