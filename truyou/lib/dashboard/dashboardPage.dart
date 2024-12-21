import 'package:flutter/material.dart';
import 'package:truyou/settingspages/mainpage.dart';

import 'package:flutter/material.dart';
import 'package:truyou/settingspages/mainpage.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPageIndex = 0;
  int currentDialogIndex = 0;

  void showDialogSequence(BuildContext context) {
    List<String> dialogQuestions = [
      "How well did you sleep?",
      "How was your nutrition?",
      "How are you feeling today?"
    ];

    String selectedOption = "Good";

    if (currentDialogIndex < dialogQuestions.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Dialog rounded corners
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dialogQuestions[currentDialogIndex],
                            style: TextStyle(
                              fontSize: constraints.maxWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Urbanist',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          ...["Excellent", "Good", "Normal", "Bad"]
                              .map((option) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(197, 239, 230, 255),
                                borderRadius: BorderRadius.circular(
                                    25), // Option rounded corners
                                border: Border.all(
                                  color: option == selectedOption
                                      ? const Color.fromARGB(255, 56, 199, 61)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: RadioListTile(
                                title: Text(
                                  option,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold, // Bold font
                                  ),
                                ),
                                value: option,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value.toString();
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            );
                          }).toList(),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFF9747FF), // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Button shape
                              ),
                              minimumSize: Size(
                                  double.infinity, 50), // Full-width button
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (currentDialogIndex <
                                  dialogQuestions.length - 1) {
                                setState(() {
                                  currentDialogIndex++;
                                });
                                showDialogSequence(context);
                              } else {
                                setState(() {
                                  currentDialogIndex = 0;
                                });
                              }
                            },
                            child: Text(
                              currentDialogIndex < dialogQuestions.length - 1
                                  ? "Next"
                                  : "Finish",
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Urbanist',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      );
    } else {
      setState(() {
        currentDialogIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: SafeArea(
              // Added SafeArea
              child: Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                child: Column(
                  children: [
                    Header(
                      userName: 'Waleed',
                      date: 'Friday, Nov 22, 2024',
                      onBackPressed: () {},
                      maxWidth: constraints.maxWidth,
                    ),
                    SizedBox(height: constraints.maxWidth * 0.04),
                    StreakCard(
                      streakCount: 1,
                      onExplore: () {
                        showDialogSequence(context);
                      },
                      maxWidth: constraints.maxWidth,
                    ),
                    SizedBox(height: constraints.maxWidth * 0.04),
                    MoodCard(
                      mood: 'Happy',
                      question: 'How was your day?',
                      onEnterMood: () {
                        print('Enter Mood tapped');
                      },
                      maxWidth: constraints.maxWidth,
                    ),
                    SizedBox(height: constraints.maxWidth * 0.04),
                    CBTProgressCard(
                      progress: 0.25,
                      onEnterCBT: () {
                        print('Enter CBT tapped');
                      },
                      maxWidth: constraints.maxWidth,
                    ),
                    SizedBox(height: constraints.maxWidth * 0.04),
                    ChatBotCard(
                      onChatBotPressed: () {
                        print('Open ChatBot tapped');
                      },
                      maxWidth: constraints.maxWidth,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_sharp),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.messenger_sharp),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}

// Other card classes remain unchanged...

class Header extends StatelessWidget {
  final String userName;
  final String date;
  final VoidCallback onBackPressed;
  final double maxWidth;

  const Header({
    Key? key,
    this.userName = 'Waleed',
    this.date = 'Friday, Nov 22, 2024',
    required this.onBackPressed,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: maxWidth * 0.65,
      decoration: BoxDecoration(
        color: Color(0xFF8B5CF6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: maxWidth * 0.032,
            left: maxWidth * 0.047,
            right: maxWidth * 0.047,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('Media/icons/dashboard.png'),
                    SizedBox(width: maxWidth * 0.02),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: maxWidth * 0.053,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => SettingsPage(),
                      //     ),
                      //   );
                      // },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Image.asset('Media/icons/bell-ring.png'),
                      ),
                    ),
                    SizedBox(width: maxWidth * 0.03),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Image.asset('Media/icons/setting.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: maxWidth * 0.17,
            left: maxWidth * 0.047,
            right: maxWidth * 0.047,
            child: Row(
              children: [
                Image.asset('Media/images/userr.png'),
                SizedBox(width: maxWidth * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $userName',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: maxWidth * 0.053,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: maxWidth * 0.001),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: maxWidth * 0.029,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: maxWidth * 0.0001,
            right: maxWidth * 0.05,
            child: Image.asset(
              'Media/images/palmtree.png',
              width: 156,
            ),
          ),
        ],
      ),
    );
  }
}

// Other card classes remain unchanged...

class StreakCard extends StatelessWidget {
  final int streakCount;
  final VoidCallback onExplore;
  final double maxWidth;

  const StreakCard({
    Key? key,
    this.streakCount = 1,
    required this.onExplore,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: maxWidth * 0.35, // Increased height
      decoration: BoxDecoration(
        color: Color(0xFFF5F5FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: maxWidth * 0.05, // Slightly increased padding
          vertical: maxWidth * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Streak',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 20, // Increased font size
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA259FF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '$streakCount',
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 24, // Increased font size
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFA259FF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6), // Increased spacing
            const Text(
              'consecutive days',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16, // Increased font size
                fontWeight: FontWeight.w400,
                color: Color(0xFFA259FF),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: maxWidth * 0.25, // Increased width
                  height: maxWidth * 0.07, // Increased height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFA259FF),
                  ),
                  child: TextButton(
                    onPressed: onExplore,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Color(0xFFA259FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Explore',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14, // Increased font size
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'Media/images/fire.png',
                  width: maxWidth * 0.1, // Increased width
                  height: maxWidth * 0.12, // Increased height
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MoodCard extends StatelessWidget {
  final String mood;
  final String question;
  final VoidCallback onEnterMood;
  final double maxWidth;

  const MoodCard({
    Key? key,
    this.mood = 'Happy',
    this.question = 'How was your day?',
    required this.onEnterMood,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: maxWidth * 0.35, // Increased height
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: maxWidth * 0.05, // Slightly increased padding
          vertical: maxWidth * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mood',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18, // Increased font size
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFCA28).withOpacity(0.8),
                  ),
                ),
                Text(
                  mood,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22, // Increased font size
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFCA28),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6), // Increased spacing
            Text(
              question,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16, // Increased font size
                fontWeight: FontWeight.w400,
                color: Color(0xFFFFCA28).withOpacity(0.8),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: maxWidth * 0.25, // Increased width
                  height: maxWidth * 0.07, // Increased height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFFFCA28),
                  ),
                  child: TextButton(
                    onPressed: onEnterMood,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Color(0xFFFFCA28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Enter Mood',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14, // Increased font size
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'Media/images/growth.png',
                  width: maxWidth * 0.12, // Increased width
                  height: maxWidth * 0.12, // Increased height
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CBTProgressCard extends StatelessWidget {
  final double progress;
  final String title;
  final String subtitle;
  final VoidCallback? onEnterCBT;
  final double maxWidth;

  const CBTProgressCard({
    Key? key,
    this.progress = 0.25,
    this.title = 'CBT Progress',
    this.subtitle = 'Take a quick exercise!',
    this.onEnterCBT,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: maxWidth * 0.35, // Increased height
      decoration: BoxDecoration(
        color: Color(0xFFE6FFF4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: maxWidth * 0.05, // Slightly increased padding
          vertical: maxWidth * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18, // Increased font size
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00D980),
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22, // Increased font size
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00D980),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Increased spacing
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16, // Increased font size
                fontWeight: FontWeight.w400,
                color: Color(0xFF00D980),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: maxWidth * 0.25, // Increased width
                  height: maxWidth * 0.07, // Increased height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF00D980),
                  ),
                  child: TextButton(
                    onPressed: onEnterCBT,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Color(0xFF00D980),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Enter CBT',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14, // Increased font size
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'Media/images/gene-therapy.png',
                  width: maxWidth * 0.12, // Increased width
                  height: maxWidth * 0.12, // Increased height
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBotCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final VoidCallback onChatBotPressed;
  final double maxWidth;

  const ChatBotCard({
    this.title = '3',
    this.subtitle = 'Conversation',
    this.description = 'TruYou Chat Wait For Ask All Day',
    required this.onChatBotPressed,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: maxWidth * 0.66, // Increased height
      decoration: BoxDecoration(
        color: Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(maxWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 40, // Increased font size
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  'Media/images/chatbot.png',
                  width: maxWidth * 0.25, // Increased width
                  height: maxWidth * 0.25, // Increased height
                ),
              ],
            ),
            // Increased spacing
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 18, // Increased font size
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            // Increased spacing
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14, // Increased font size
                fontWeight: FontWeight.w400,
                color: Color(0xFFC0B1E8),
              ),
            ),
            Spacer(),
            Container(
              width: maxWidth * 0.5, // Increased width
              height: maxWidth * 0.12, // Increased height
              decoration: BoxDecoration(
                color: Color(0xFF9747FF),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onChatBotPressed,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Text(
                      'Open ChatBot',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16, // Increased font size
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
