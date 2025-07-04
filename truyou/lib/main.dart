import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'package:truyou/Login-Sginup/Sign_Up.dart';
// import 'package:truyou/Login-Sginup/Sign_in.dart';
// import 'package:truyou/screens/Sign_in.dart';


import 'package:truyou/Login-Sginup/PasswordRecover.dart';
import 'package:truyou/Login-Sginup/Sign_Up.dart';
import 'package:truyou/Login-Sginup/Sign_in.dart';
import 'package:truyou/Login-Sginup/SplashScreen.dart';
import 'package:truyou/cbt/CBT_programs.dart';
import 'package:truyou/chatboot/creatnewchat.dart';
import 'package:truyou/dashboard/dashboardPage.dart';
import 'package:truyou/selfAssessmentPages/responsescrean.dart';
import 'package:truyou/selfAssessmentPages/self_assessment_welcome.dart';
import 'package:truyou/welcomeScreens/welcomescreen.dart';
import 'package:truyou/welcomeScreens/welcomescreenCBT.dart';
import 'package:truyou/welcomeScreens/welcomescreenChatBot.dart';
import 'package:truyou/welcomeScreens/welcomescreenExplore.dart';
import 'package:truyou/welcomeScreens/welcomescreenSelf_assesment.dart';

import 'package:truyou/chatboot/chat.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is only initialized once
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCJ5apGf7VmnxqvciPz_IZD--IuY2mYl-M",
        appId: "1:37382526611:android:d7d499f9d18de118d79f66",
        messagingSenderId: "37382526611",
        projectId: "tru-you-n",
      ),
    );
  } catch (e) {
    print("Firebase is already initialized");
  }

  runApp(TruYouApp());
}



class TruYouApp extends StatelessWidget {
  const TruYouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      initialRoute: '/splash',
      routes: {
        '/dashboard': (context) => DashboardPage(diagnoses: [],),
        '/chatstart': (context) => const Creatnewchat(),
        '/chatbot': (context) => ChatScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/cbt': (context) => const Welcomescreencbt(),
        '/diagnose': (context) => const DiagnoseScreen(answers: [], diagnoses: [],),
        '/chatbotwelcome': (context) => const Welcomescreenchatbot(),
        '/cbtpage': (context) => const ExampleScreen(programs: [], diagnoses: [],),
        '/explore': (context) => const Welcomescreenexplore(),
        '/self_assessment': (context) => const WelcomescreenselfAssesment(),
        '/splash': (context) => SplashScreen(),
        '/Welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/Pass': (context) => const PasswordRECOBERY(),
        '/zezo': (context) => const SelfAssessmentWelcome(),
      },
    );

  }
}