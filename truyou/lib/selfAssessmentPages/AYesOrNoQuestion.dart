import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Yesornoquestion extends StatefulWidget {
  const Yesornoquestion({Key? key}) : super(key: key);

  @override
  YesOrNoQuestionScreenState createState() => YesOrNoQuestionScreenState();
}

class YesOrNoQuestionScreenState extends State<Yesornoquestion> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {}, // Add functionality for back button
                      child:Image(image: AssetImage("Media/icons/previous.png"))
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  'Do you experience sudden mood swings throughout the day?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    height: 1.27,
                    color: Colors.black,
                  ),
                ),
              ),
              Spacer(), // Pushes the following widgets to the bottom
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => setState(() => selectedOption = 'Yes'),
                          child: Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              color: selectedOption == 'Yes' ? Color.fromARGB(255, 217, 206, 244) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(35), // Make it oval
                            ),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.2,
                                  color: Color(0xFFA259FF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => setState(() => selectedOption = 'No'),
                          child: Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              color: selectedOption == 'No' ? Color.fromARGB(255, 217, 206, 244) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(35), // Make it oval
                            ),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.2,
                                  color: Color(0xFFA259FF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (selectedOption != null) {
                          // Handle continue action
                        }
                      },
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0xFFA259FF),
                          borderRadius: BorderRadius.circular(35), // Make it oval
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), // Add some space at the bottom
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
