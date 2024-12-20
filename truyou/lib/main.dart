import 'package:flutter/material.dart';
import 'package:truyou/selfAssessmentPages/AYesOrNoQuestion.dart';
import 'package:truyou/selfAssessmentPages/scaleQuestion.dart';
// import 'package:truyou/Login-Sginup/Sign_Up.dart';
// import 'package:truyou/Login-Sginup/Sign_in.dart';
// import 'package:truyou/screens/Sign_in.dart';

import 'package:truyou/welcomeScreens/welcomescreen.dart';
import 'package:truyou/welcomeScreens/welcomescreenCBT.dart';
import 'package:truyou/welcomeScreens/welcomescreenChatBot.dart';
import 'package:truyou/welcomeScreens/welcomescreenExplore.dart';
import 'package:truyou/welcomeScreens/welcomescreenSelf_assesment.dart';



void main() {
  runApp(const TruYouApp());
}

class TruYouApp extends StatelessWidget {
  const TruYouApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const yesOrNoQuestion();
         // Removes the debug banner

        // initialRoute: '/',
        // routes: {
        //   '/': (context) => const WelcomeScreen(),
        //   '/cbt': (context) => const Welcomescreencbt(),
        //   '/chatbot': (context) => const Welcomescreenchatbot(),
        //   '/explore': (context) => const Welcomescreenexplore(),
        //   '/self_assessment': (context) => const WelcomescreenselfAssesment(),
        // }    

  }
}
