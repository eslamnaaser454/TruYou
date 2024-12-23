import 'package:flutter/material.dart';
import 'package:truyou/selfAssessmentPages/yesOrNoQuestionPage.dart';
import 'mulChoiceQuestionPage.dart'; // Adjust based on your actual file name

class ScaleQuestionPage extends StatefulWidget {
  final String question;
  final double currentValue; // Current value of the slider
  final ValueChanged<double> onValueChanged; // Callback to update value in parent
  final VoidCallback onContinue;
  final VoidCallback? onBack;

  const ScaleQuestionPage({
    required this.question,
    required this.currentValue,
    required this.onValueChanged,
    required this.onContinue,
    this.onBack,
    super.key,
  });

  @override
  _ScaleQuestionPageState createState() => _ScaleQuestionPageState();
}

class _ScaleQuestionPageState extends State<ScaleQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.03),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: widget.onBack,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            widget.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.w700,
              height: 1.27,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Slider(
            value: widget.currentValue,
            min: 1,
            max: 10,
            divisions: 9,
            label: widget.currentValue.round().toString(),
            onChanged: widget.onValueChanged, // Notify parent of slider changes
          ),
          Text(
            'Selected: ${widget.currentValue.round()}',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w800,
              color: Color(0xFFA259FF),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: widget.onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA259FF),
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}

class ScaleQuestionFlow extends StatefulWidget {

  final List<String> answers; // Collect answers from Yes/No questions

  const ScaleQuestionFlow({
    required this.answers,
    super.key,
  });

  @override
  _ScaleQuestionFlowState createState() => _ScaleQuestionFlowState();
}

class _ScaleQuestionFlowState extends State<ScaleQuestionFlow> {
  late List<String> answers;
  double selectedValue = 5; // Default slider value

  @override
  void initState() {
    super.initState();
    answers = widget.answers;
  }

  int currentPageIndex = 0;

  final List<String> scaleQuestions = [
    "On a scale of 1 to 10, how often do you feel sad or down without a clear reason?",
    "On a scale of 1 to 10, how often do you feel tense or anxious?",
    "On a scale of 1 to 10, how motivated do you feel to complete daily tasks?",
    "On a scale of 1 to 10, how difficult has it been to concentrate on tasks or make decisions?",
    "On a scale of 1 to 10, how often do you feel physically exhausted even after a full night's rest?",
    "On a scale of 1 to 10, how satisfied are you with yourself and your life?",
  ];

  void _onContinue(double value) {
    answers.add(value.round().toString()); // Save the slider value

    if (currentPageIndex < scaleQuestions.length - 1) {
      setState(() {
        currentPageIndex++;
      });
    } else {
      // Navigate to Multiple Choice Questions page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => mulChoiceQuestion(
            answers: answers,
          ),
        ),
      );
    }
  }

  void goToPreviousQuestion() {
    if (currentPageIndex == 0){
      setState(() {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => (YesNoQuestionFlow()),
          ),
        );
      });
    }

    if (currentPageIndex > 0) {
      setState(() {
        currentPageIndex--;
        if (answers.isNotEmpty) {
          answers.removeLast(); // Remove the last answer
        }
        selectedValue = 5; // Reset the selection
      });
    }
  }

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ScaleQuestionPage(
          question: scaleQuestions[currentPageIndex],
          currentValue: selectedValue, // Pass the current slider value
          onValueChanged: (value) {    // Pass the callback to update the slider value
            setState(() {
              selectedValue = value;
            });
          },
          onContinue: () => _onContinue(selectedValue),
          onBack: goToPreviousQuestion,
        ),
      ),
    ),
  );
}
}
