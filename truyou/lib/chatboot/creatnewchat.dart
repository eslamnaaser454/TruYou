import 'package:flutter/material.dart';
import 'package:truyou/actionBar/actionBar.dart'; // Import ActionBar
import 'package:truyou/dashboard/dashboardPage.dart'; // Import DashboardPage
import 'package:truyou/chatboot/chatstart.dart'; // Import ChatbotstartScreen
import 'package:truyou/profile/profilepage.dart'; // Import ProfilePage

class Creatnewchat extends StatelessWidget {
  const Creatnewchat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int currentPageIndex = 3;

    void _onItemTapped(int index) {
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotstartScreen()),
          );
          break;
        // case 4:
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProfilePage(
        //             email: 'user@example.com')), // Pass the email as needed
        //   );
        //   break;
        default:
          // Handle other cases if necessary
          break;
      }
    }

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.05, // Adjust top padding for positioning
                left: size.width * 0.04, // Adjust left padding for spacing
                right: size.width * 0.04, // Optional: Add right padding
                bottom: size.height * 0.02, // Optional: Add bottom padding
              ),
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
                  SizedBox(width: size.width * 0.02),
                  const Text(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Assets/Logo/box.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    'Empty !',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFA259FF),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  const Text(
                    'No Conversation yet',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(51, 14, 5, 37),
                    ),
                  ),
                ],
              ),
            ),

            // Create New Conversation Button
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.09),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the Create New Conversation screen
                  Navigator.pushNamed(context, '/chatbot');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA259FF),
                  minimumSize: Size(size.width * 0.7, size.height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Create new conversation',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16,
                    height: 3,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
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
