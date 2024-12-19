import 'package:flutter/material.dart';

class ChatbotstartScreen extends StatelessWidget {
  const ChatbotstartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back to the previous screen
                    },
                  ),
                  const SizedBox(width: 0.1),
                  Text(
                    'ChatBot',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Assets/Logo/chatboot.png',
                        width: 110,
                        height: 110,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'ChatBot',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFFA259FF),
                        ),
                      ),
                      const SizedBox(height: 44),
                      Text(
                        'Talk To TruYou Ai ChatBot',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Color(0xFFA259FF),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'You have no Ai conversations\nyou can create your first one now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xB2C0B1E8),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/chatstart');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: Size(261, 45),
                          side: BorderSide(
                            color: Color(0xFFA259FF),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Talk to Truyou',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Color(0xFFA259FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
