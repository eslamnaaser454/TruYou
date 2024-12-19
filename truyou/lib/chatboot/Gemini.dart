import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Ensure this package is correct

class Geminichatbot extends StatefulWidget {
  const Geminichatbot({super.key});
  @override
  State<Geminichatbot> createState() => _GeminichatbotState();
}

class _GeminichatbotState extends State<Geminichatbot> {
  static const apiKey = 'AIzaSyAMEF5S1J8DFA7Ayg2_UJdPETf1FfzSDtQ'; // Replace with your actual API key
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  // This method now generates content based on the user message
  Future<String> getResponse(String userMessage) async {
    try {
      // Create the prompt with the user message
      final prompt = userMessage;
      final content = [Content.text(prompt)];

      // Get the generated response from the model
      final response = await model.generateContent(content);

      return response.text ?? "Oops! Something went wrong.";
    } catch (e) {
      return "Oops! Something went wrong. Please try again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(); // Customize as needed
  }
}
