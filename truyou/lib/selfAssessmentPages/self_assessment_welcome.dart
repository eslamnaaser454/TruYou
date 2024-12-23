import 'package:flutter/material.dart';
import 'package:truyou/selfAssessmentPages/yesOrNoQuestionPage.dart';

class SelfAssessmentWelcome extends StatelessWidget {
  const SelfAssessmentWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding =
        screenWidth > 600 ? 40.0 : 20.0; // Adjust thresholds as needed

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: Scaffold(
        backgroundColor: Colors.white, // Set background color to white
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Welcome to Self Assessment Form',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.27,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    'Media/images/Select-cuate.png',
                  ),
                  const SizedBox(height: 17),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5EEFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 18),
                          Image.asset(
                    'Media/icons/information.png',
                    width: 20,
                    height: 20,

                  ),
                          const SizedBox(width: 15),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: const Text(
                              'Please Complete Self Assessment Form carefully',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.14,
                                height: 1.2,
                                color: Color(0xFFA259FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 41),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press action
                       Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => YesNoQuestionFlow()), // Navigate to Scale Question page
    );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9A4AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
