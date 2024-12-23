import 'package:flutter/material.dart';
import 'package:truyou/selfAssessmentPages/self_assessment_welcome.dart';
import 'scaleQuestionPage.dart'; // Ensure this import points to the correct file

class YesNoQuestionFlow extends StatefulWidget {
  const YesNoQuestionFlow({Key? key}) : super(key: key);

  @override
  State<YesNoQuestionFlow> createState() => _YesNoQuestionFlowState();
}

class _YesNoQuestionFlowState extends State<YesNoQuestionFlow> {
  final List<String> questions = [
    'Do you experience sudden mood swings throughout the day?',
    'In the past month, have you experienced physical symptoms of anxiety, like a racing heart or sweating, without an obvious cause?',
    'Do you find it difficult to fall asleep or stay asleep most nights?',
    'Have you been avoiding social interactions or isolating yourself more than usual?',
    'Do you frequently forget important dates, tasks, or events?',
    'Have you noticed a decline in your ability to think or process information clearly?',
    'Have you experienced feelings of guilt or worthlessness more than usual in the past month?',
    'Do you feel supported and connected to the people around you?',
    'In the past month, have you had recurring distressing memories or dreams about a specific event?',
    'Do you find yourself avoiding thoughts, places, or people that remind you of a past traumatic event?',
    'Over the past month, have you noticed significant changes in your appetite (eating much more or much less than usual)?',
    'Have you been excessively concerned about your weight or body shape in a way that impacts your daily life?',
    'In the past month, have you consumed alcohol, drugs, or other substances to cope with stress or emotional discomfort?',
  ];

  int currentQuestionIndex = 0;
  String? selectedOption;

  // Shared list to collect answers
  List<String> answers = [];

  void goToNextQuestion() {
    if (selectedOption != null) {
      answers.add(selectedOption!); // Save the selected answer

      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedOption = null; // Reset the selection for the next question
        });
      } else {
        // End of Yes/No questions; navigate to Scale Questions
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScaleQuestionFlow(answers: answers),
          ),
        );
      }
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex == 0){
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => (SelfAssessmentWelcome()),
          ),
        );
      });
    }
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        if (answers.isNotEmpty) {
          answers.removeLast(); // Remove the last answer
        }
        selectedOption = null; // Reset the selection
      });
    }
  }

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
                      onTap: goToPreviousQuestion,
                      child: Image(
                        image: AssetImage("Media/icons/previous.png"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  questions[currentQuestionIndex],
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
              Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => selectedOption = 'Yes'),
                        child: Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: selectedOption == 'Yes'
                                ? Color.fromARGB(255, 217, 206, 244)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFA259FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      GestureDetector(
                        onTap: () => setState(() => selectedOption = 'No'),
                        child: Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: selectedOption == 'No'
                                ? Color.fromARGB(255, 217, 206, 244)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFA259FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: goToNextQuestion,
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: Color(0xFFA259FF),
                        borderRadius: BorderRadius.circular(35),
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
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
