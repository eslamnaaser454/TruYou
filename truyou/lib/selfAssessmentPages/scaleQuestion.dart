import 'package:flutter/material.dart';

class scaleQuestion extends StatefulWidget {
  const scaleQuestion({Key? key}) : super(key: key);

  @override
  _scaleQuestionState createState() => _scaleQuestionState();
}

class _scaleQuestionState extends State<scaleQuestion> {
  double selectedValue = 5; // Default value for the slider

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
                      child: Image(image: AssetImage("Media/icons/previous.png")),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  'On a scale of 1 to 10, how often do you feel sad or down without a clear reason?',
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
                  Slider(
                    value: selectedValue,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: selectedValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  Text(
                    'Selected: ${selectedValue.round()}',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFA259FF),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // Handle continue action
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
