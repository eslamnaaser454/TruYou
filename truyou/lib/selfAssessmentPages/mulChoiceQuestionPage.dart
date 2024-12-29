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
   
  ];
  
  double depressionScore=0, anxietyScore=0,bipolarScore=0,ptsdScore=0,socialAnxietyScore=0;

  void _onContinue(int selectedChoice) {
    // Save the current selection
    widget.answers.add(selectedChoice.toString());

    // Navigate or move to the next page
    setState(() {
      if (currentPageIndex < pages.length - 1) {
        currentPageIndex++;
      } else {
        // All questions answered, print answers to the debug console
        print("User's Answers:");
        for (var answer in widget.answers) {
          if(int.parse(widget.answers[0]) ==1){
            // depressionScore++;
            anxietyScore++;
            bipolarScore++;
            //ptsdScore++;
            // socialAnxietyScore++;

          }
            if(int.parse(widget.answers[1])==1){
            //depressionScore++;
            anxietyScore++;
            anxietyScore++;
            //bipolarScore++;
            //ptsdScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[2])==1){
            depressionScore++;
            anxietyScore++;
            // bipolarScore++;
            // ptsdScore++;
            //socialAnxietyScore++;

          }
            if(int.parse(widget.answers[3])==1){
            depressionScore++;
            //anxietyScore++;
            //bipolarScore++;
            //ptsdScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[4]) ==1){
            depressionScore++;
            anxietyScore++;
            bipolarScore++;
            ptsdScore++;
            //socialAnxietyScore++;

          }
            if(int.parse(widget.answers[5]) ==0){
            //depressionScore++;
            //anxietyScore++;
            bipolarScore++;
            //ptsdScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[6]) ==1){
            //depressionScore++;
            //anxietyScore++;
            //bipolarScore++;
            ptsdScore++;
            ptsdScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[7]) ==1){
            depressionScore++;
            anxietyScore++;
            //bipolarScore++;
            //ptsdScore++;
            //socialAnxietyScore++;

          }
            if(int.parse(widget.answers[8]) ==1){
            //depressionScore++;
            anxietyScore++;
            bipolarScore++;
            //ptsdScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[9]) ==1){
            depressionScore++;
            anxietyScore++;
            //bipolarScore++;
            //ptsdScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[10]) >=5){
            depressionScore++;
            //anxietyScore++;
            //bipolarScore++;
            ptsdScore++;
            socialAnxietyScore++;
            socialAnxietyScore++;

          }
            if(int.parse(widget.answers[11])>=5){
            //depressionScore++;
            anxietyScore++;
            anxietyScore++;
            //bipolarScore++;
            //ptsdScore++;
            //socialAnxietyScore++;

          }
            if(int.parse(widget.answers[12]) <=5){
            depressionScore++;
            //anxietyScore++;
            bipolarScore++;
            //ptsdScore++;
            //socialAnxietyScore++;

          }
            if(int.parse(widget.answers[13]) ==3){
            depressionScore++;
            depressionScore++;
            anxietyScore++;
            bipolarScore++;
            bipolarScore++;
            // ptsdScore++;
            // socialAnxietyScore++;

          }else if(int.parse(widget.answers[13]) ==2){
            depressionScore++;
            anxietyScore++;
            bipolarScore++;

          }else if(int.parse(widget.answers[13]) ==1){
            bipolarScore++;
          }


          print(answer);  // Prints each answer to the console
        }
        print("ptsdScore");print(ptsdScore);
        print("depr_score");print(depressionScore);
        print("socialAnex_score");print(socialAnxietyScore);
        print("anex_score");print(anxietyScore);
        print("bipo_score");print(bipolarScore);

        bool hasDepression=false, hasPTSD=false,hasSocialAnex=false,hasBiPo=false,hasAnex=false;
        String  Ptsd,depression,socialAnex,Anex,biPolar;
        if(ptsdScore>=42){
          hasPTSD=true;
          Ptsd='PTSD Yes';
         
        } else{
          Ptsd='PTSD No';
          
        }
        if(depressionScore>=60){
          hasDepression=true;
          depression='Depression Yes';
        }else{
          depression='Depression No';
        }
        if(anxietyScore>=60){
          hasAnex=true;
        Anex='Anexity Yes';
        }
        else{
          Anex='Anexity No';
        }
        if(socialAnxietyScore>=56){
          hasSocialAnex=true;
          socialAnex='social Anexity Yes';
        }else{
          socialAnex='social Anexity No';
        }
        if(bipolarScore>=70){
          hasBiPo=true;
          biPolar='Bipolar Yes';
        }else{
          biPolar='Bipolar No';
        }


List<String> diagnoses = [
  Ptsd,
  depression,
  Anex,
  socialAnex,
  biPolar,
];
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnoseScreen(diagnoses: diagnoses, answers: [],),
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
