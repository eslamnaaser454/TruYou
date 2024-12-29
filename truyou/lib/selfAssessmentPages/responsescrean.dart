import 'package:flutter/material.dart';
import 'package:truyou/cbt/ProgramDetailPage.dart';
import 'package:truyou/selfAssessmentPages/selfAssessmentDone.dart';

class DiagnoseScreen extends StatelessWidget {
  const DiagnoseScreen({
    Key? key,
    this.diagnosis = 'You seem to have depression',
    this.disclaimer =
        'This diagnosis is inaccurate. Please visit a specialist to verify the diagnosis.',
    required this.diagnoses,
    required List answers,
  }) : super(key: key);

  final String diagnosis;
  final String disclaimer;
  final List<String> diagnoses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Make the page scrollable
          child: Column(
            children: [
              // Header with back button and title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC0B1E8).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Diagnose',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Diagnosis text
                    Text(
                      diagnosis.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        color: Colors.black,
                        height: 1.27, // Line height
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Image
                    Image.asset(
                      'Media/images/person 1.png', // Replace with your local asset path
                      width: 206,
                      height: 206,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    // Disclaimer text
                    Text(
                      disclaimer,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2,
                        color: Colors.black.withOpacity(0.5),
                        height: 1.25, // Line height
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Dynamic Text View for Diagnoses
                    Column(
                      children: diagnoses.map((diagnosis) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            diagnosis.toString(),
                            style: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                    // Responsive Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadyToCommitScreen(onReadyPressed: () {}, diagnoses: [],),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA259FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
