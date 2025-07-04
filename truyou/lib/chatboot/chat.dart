import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Assuming this package is used for the API
import 'package:truyou/cbt/CBT_programs.dart';
import 'package:truyou/chatboot/model.dart';
import 'package:truyou/actionBar/actionBar.dart'; // Import ActionBar
import 'package:truyou/dashboard/dashboardPage.dart'; // Import DashboardPage
import 'package:truyou/chatboot/chatstart.dart'; // Import ChatbotstartScreen
import 'package:truyou/explore/explore.dart';
import 'package:truyou/profile/profilepage.dart'; // Import ProfilePage
import 'model.dart'; // Assuming the MessageModel is in a separate file named model.dart
import 'Gemini.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<MessageModel> _messages = [];
  int currentPageIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });

     switch (index) {
            case 0:
            
              break;
              case 1:
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExampleScreen(programs: [], diagnoses: [],),
             
              ));
              case 2:
              
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            case 3:
             
              break;
             case 4:
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => ProfilePage()), // Pass the email as needed
               );
               break;
            default:
              // Handle other cases if necessary
              break;
          }
  }

  // Create the GenerativeModel instance
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash-latest', // Replace with the correct model
    apiKey:
        'AIzaSyAMEF5S1J8DFA7Ayg2_UJdPETf1FfzSDtQ', // Replace with actual API key
  );
final directive = """
You are a chatbot specialized in mental health and psychological support. 
Your goal is to help users with emotional well-being by engaging in thoughtful, context-aware conversations. 
You should:
- Respond to topics related to mental health, stress, emotions, and coping strategies.
- Acknowledge and address the user’s emotional state as inferred from their queries.
- Reflect on the user’s past messages to provide context-aware responses.
- Offer helpful resources, general advice, or reflective prompts when applicable.
- Maintain an empathetic and supportive tone throughout the conversation.

If a topic is unrelated to mental health, kindly redirect the user to focus on mental health-related discussions.
""";
  // Send message to the model and get the response
  
Future<void> _sendMessage() async {
  if (_controller.text.isNotEmpty) {
    final userMessage = MessageModel(
      isUser: true,
      message: _controller.text,
      time: DateTime.now(),
    );

    // Add the user's message to the list
    setState(() {
      _messages.add(userMessage);
    });

    // Clear the input field
    _controller.clear();

    // Combine previous messages for context
    final conversationHistory = _messages
        .map((msg) => msg.isUser ? "User: ${msg.message}" : "Bot: ${msg.message}")
        .join('\n');

    // Prepare the prompt with the conversation history
    final prompt = """
$directive

Conversation so far:
$conversationHistory

User: ${userMessage.message}
""";

    try {
      final content = [Content.text(prompt)];

      // Add a "typing" placeholder
      setState(() {
        _messages.add(MessageModel(
          isUser: false,
          message: "Typing...",
          time: DateTime.now(),
        ));
      });

      // Get the response from the model
      final response = await _model.generateContent(content);

      // Remove the "typing" placeholder
      setState(() {
        _messages.removeWhere((msg) => msg.message == "Typing...");
      });

      if (response.text != null) {
        final botMessage = MessageModel(
          isUser: false,
          message: response.text!,
          time: DateTime.now(),
        );

        // Add the bot's response to the message list
        setState(() {
          _messages.add(botMessage);
        });
      } else {
        setState(() {
          _messages.add(MessageModel(
            isUser: false,
            message:
                "I'm here to assist with mental health and psychological support. Let's focus on your well-being.",
            time: DateTime.now(),
          ));
        });
      }
    } catch (e) {
      print('Error: $e');
      // Handle errors gracefully
      setState(() {
        _messages.removeWhere((msg) => msg.message == "Typing...");
        _messages.add(MessageModel(
          isUser: false,
          message: "Oops! Something went wrong. Please try again.",
          time: DateTime.now(),
        ));
      });
    }
  }
}
// Helper function to validate if the response relates to mental health topics
  bool _isMentalHealthRelated(String message) {
    final mentalHealthKeywords = [
      'mental health',
      'psychological support',
      'anxiety',
      'stress',
      'depression',
      'anger management',
      'cognitive behavioral therapy',
      'cbt',
      'emotional well-being',
      'self-care',
      'trauma',
      'ptsd',
      'grief',
      'loss',
      'relationships',
      'communication issues',
      'mindfulness',
      'relaxation',
      'coping',
      'mental wellness',
      'life transitions',
    ];
    return mentalHealthKeywords
        .any((keyword) => message.toLowerCase().contains(keyword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(title: 'ChatBot'),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message.message,
                    isUser: message.isUser,
                    timestamp: message.time,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color(0xFFA259FF).withOpacity(0.2),
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type To start Conversation",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(162, 89, 255, 1)
                                .withOpacity(0.3),
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 51.77,
                      height: 45,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Color(0xFFA259FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ActionBar(
        selectedIndex: currentPageIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class ChatHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const ChatHeader({
    Key? key,
    this.title = 'ChatBot',
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFF8B5CF6),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 30,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF8B5CF6),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 35,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Image.asset(
                  'Assets/Logo/ai2.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  MessageBubble({
    this.message =
        "Focus on your senses. Notice the ground, sounds, and smells.",
    this.isUser = false,
    DateTime? timestamp,
  }) : this.timestamp = timestamp ?? DateTime.now();

  String _formatTimestamp(DateTime timestamp) {
    String period = timestamp.hour >= 12 ? 'PM' : 'AM';
    int hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
    String minute = timestamp.minute.toString().padLeft(2, '0');
    return 'Sent in $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: isUser ? Color(0xFFA259FF) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: !isUser
                  ? Border.all(
                      color: Color(0xFFA259FF).withOpacity(0.2),
                    )
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isUser) ...[
                  Image.asset(
                    'Assets/Logo/brain.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                  ),
                  SizedBox(width: 10),
                ],
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isUser ? Colors.white : Color(0xFFA259FF),
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isUser) ...[
                  SizedBox(width: 10),
                  Image.asset(
                    'Assets/Logo/user.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            _formatTimestamp(timestamp),
            style: TextStyle(
              color: Color(0xFFA259FF),
              fontFamily: 'Urbanist',
              fontSize: 8,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}