import 'package:flutter/material.dart';
import 'package:truyou/selfAssessmentPages/responsescrean.dart';
import 'selfAssessmentDone.dart';

class mulChoiceQuestion extends StatefulWidget {
  final  List<String> answers; // Collect answers from previous questions

  const mulChoiceQuestion({required this.answers, super.key});

  @override
  _mulChoiceQuestionState createState() => _mulChoiceQuestionState();

  
}

class _mulChoiceQuestionState extends State<mulChoiceQuestion> {
  
  late List<String> answers;
  late int selectedChoice;

void initState(){
super.initState();
// WidgetsBinding.instance.addPostFrameCallback
answers=widget.answers;
}


  
  int currentPageIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'question': "Over the past two weeks, how often have you lost interest in activities you usually enjoy?",
      'choices': ['Never', 'Occasionally', 'Often', 'Almost always'],
    },
    {
      'question': "How often do you find it difficult to control your worries?",
      'choices': ['Rarely', 'Sometimes', 'Often', 'Very often'],
    },
    {
      'question': "How would you rate the quality of your sleep over the past month?",
      'choices': ['Excellent', 'Good', 'Fair', 'Poor'],
    },
    {
      'question': "On average, how many hours of sleep do you get per night?",
      'choices': ['Less than 4 hours', '4~6 hours', '6~8 hours', 'More than 8 hours'],
    },
    {
      'question': "Over the past month, how often have you acted impulsively or made decisions without much thought?",
      'choices': ['Never', 'Occasionally', 'Often', 'Almost always'],
    },
    {
      'question': "Over the past month, how often have you experienced unexplained physical symptoms like headaches, fatigue, or stomach issues?",
      'choices': ['Never', 'Occasionally', 'Often', 'Very often'],
    },
  ];

  void _onContinue(int selectedChoice) {
    // Save the current selection
    widget.answers.add(pages[currentPageIndex]['choices'][selectedChoice]);

    // Navigate or move to the next page
    setState(() {
      if (currentPageIndex < pages.length - 1) {
        currentPageIndex++;
      } else {
        // All questions answered, print answers to the debug console
        print("User's Answers:");
        for (var answer in widget.answers) {
          print(answer);  // Prints each answer to the console
        }

        // // Navigate to the ReadyToCommitScreen without passing the answers
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ReadyToCommitScreen(onReadyPressed: () {  },),
        //   ),
        // );
           // Navigate to the ReadyToCommitScreen without passing the answers
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnoseScreen(answers: widget.answers),
          ),
        );
        
      }
    });
  }

  void goToPreviousQuestion() {
    if (currentPageIndex > 0) {
      setState(() {
        currentPageIndex--;
        if (answers.isNotEmpty) {
          answers.removeLast(); // Remove the last answer
        }
        selectedChoice = 0; // Reset the selection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: goToPreviousQuestion,
              child: Image(
                image: AssetImage("Media/icons/previous.png"),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: QuestionPage(
            question: pages[currentPageIndex]['question'],
            choices: pages[currentPageIndex]['choices'],
            onContinue: (selectedChoice) => _onContinue(selectedChoice),
          ),
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  final String question;
  final List<String> choices;
  final Function(int) onContinue;

  const QuestionPage({
    required this.question,
    required this.choices,
    required this.onContinue,
    super.key,
  });

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedChoice = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 72),
          Text(
            widget.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              height: 1.27,
            ),
          ),
          const SizedBox(height: 35),
          ...List.generate(widget.choices.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: GestureDetector(
                onTap: () => setState(() => selectedChoice = index),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: selectedChoice == index
                        ? Colors.white
                        : const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(24),
                    border: selectedChoice == index
                        ? Border.all(color: const Color(0xFF02D4A8), width: 2)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          widget.choices[index],
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.042,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedChoice == index
                                  ? const Color(0xFF02D4A8)
                                  : Colors.black.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: selectedChoice == index
                              ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF02D4A8),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ElevatedButton(
              onPressed: () => widget.onContinue(selectedChoice),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7E6BF2),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
