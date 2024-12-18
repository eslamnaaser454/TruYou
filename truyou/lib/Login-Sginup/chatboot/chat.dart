import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> _messages = [];
  final List<String> _autoReplies = [
    "Understand your feelings. Let's start with deep breathing.",
    "Let's try a different approach. Mindful walking?",
    "Remember to take breaks. You're doing great!",
    "Try to focus on the present moment. What do you see around you?",
    "Remember to take care of yourself. Have you had water today?",
    "Focus on your senses. Notice the ground, sounds, and smells.",
    "Take things one step at a time. You've got this.",
    "Remember, small progress is still progress."
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _controller.text,
          "isUser": true,
          "timestamp": DateTime.now()
        });
        String reply = _autoReplies[_messages.length % _autoReplies.length];
        _messages
            .add({"text": reply, "isUser": false, "timestamp": DateTime.now()});
        _controller.clear();
      });
    }
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
                    message: message['text'],
                    isUser: message['isUser'],
                    timestamp: message['timestamp'],
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
                        borderRadius: BorderRadius.circular(
                            30), // Increased to make it more rounded
                        border: Border.all(
                          color: Color(0xFFA259FF)
                              .withOpacity(0.2), // Light border color
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
                      padding:
                          EdgeInsets.all(7), // Padding ensures consistent size
                      decoration: BoxDecoration(
                        color: Color(0xFFA259FF), // Background color
                        shape: BoxShape
                            .circle, // Makes the container a perfect circle
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
        color: Color(0xFF8B5CF6), // Header background color
        borderRadius: BorderRadius.all(
          Radius.circular(16), // Rounded corners for the header
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Arrow with Padding
          Padding(
            padding: const EdgeInsets.only(left: 8.0), // Padding for left arrow
            child: Stack(
              alignment: Alignment.center,
              children: [
                // White Circular Background
                Container(
                  width: 30,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white, // Background color
                    shape: BoxShape.circle, // Circular shape
                  ),
                ),
                // Arrow Icon
                GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF8B5CF6), // Purple color for the arrow
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          // Title (Center)
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),

          // AI Logo with Padding
          Padding(
            padding: const EdgeInsets.only(right: 8.0), // Padding for AI logo
            child: Stack(
              alignment: Alignment.center,
              children: [
                // White Circular Background
                Container(
                  width: 35,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white, // Background color
                    shape: BoxShape.circle, // Circular shape
                  ),
                ),
                // AI Logo Image
                Image.asset(
                  'Assets/Logo/ai2.png', // Path to AI logo
                  width: 36, // Adjust logo size
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
              maxWidth: 237,
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
                  // AI Image next to AI's message
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

                // Message Text
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isUser ? Colors.white : Color(0xFFA259FF),
                      fontFamily: 'Urbanist',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // For User's Message, show the user's image beside their message (on the right)
                if (isUser) ...[
                  SizedBox(
                      width: 10), // Add space between message and user image
                  Image.asset(
                    'Assets/Logo/user.png', // User image path
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
