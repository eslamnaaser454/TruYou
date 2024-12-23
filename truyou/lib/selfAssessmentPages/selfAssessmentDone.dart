import 'package:flutter/material.dart';
import 'package:truyou/dashboard/dashboardPage.dart';

class ReadyToCommitScreen extends StatelessWidget {
  const ReadyToCommitScreen({
    super.key,
    required this.onReadyPressed,
    this.title = 'Are you ready to commit for a better mental health?',
    this.completionText = 'Self Assessment Complete !',
    this.buttonText = 'I am ready',
  });

  final VoidCallback onReadyPressed;
  final String title;
  final String completionText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 77),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    height: 1.27, // 38px line height / 30px font size
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  width: 172,
                  height: 172,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA259FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  width: 314,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F1FF),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFFA259FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        completionText,
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.16,
                          color: Color(0xFFA259FF),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 307,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
    // Perform any additional actions here (if needed)
    onReadyPressed();

    // Navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()), // Replace HomePage with your actual home page widget
    );
  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA259FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        buttonText,
                        
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
