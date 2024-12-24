// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';
// import 'package:truyou/Login-Sginup/Confirmpopup.dart';
// import 'package:truyou/cbt/CBT_programs.dart';
// import 'package:truyou/chatboot/chatstart.dart';
// import 'package:truyou/explore/explore.dart';
// import 'package:truyou/notification/notification.dart';
// import 'package:truyou/profile/profilepage.dart';
// import 'package:truyou/settingspages/mainpage.dart';
// import 'package:truyou/actionBar/actionBar.dart'; // Import the ActionBar

// class DashboardPage extends StatefulWidget {
//   @override
//   _DashboardPageState createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   int currentPageIndex = 0;
//   int currentDialogIndex = 0;
//   double progress = 0.0;
//   Future<void> getProgress() async {
//                       // Get the current user
//                       final User? user = FirebaseAuth.instance.currentUser;

//                       if (user != null) {
//                         // Fetch the progress from Firestore (assuming user ID is used as document ID)
//                         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(user.uid) // Use current user's UID as document ID
//                             .get();

//                         if (userDoc.exists) {
//                           // Assuming the field name in Firestore is 'progress'
//                           double progress1 = userDoc['progress'] ?? 0.0;
//                           setState(() {
//                             progress = progress1;
//                           });
//                           // return progress;
//                         } else {
//                           // return 0.0;
//                         }
//                       } else {
//                         // return 0.0;
//                       }

//                     }

//   @override
//   void initState() {
//     super.initState();
//     // Call _showDoneDialog when the page starts
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//     _showDoneDialog(context, "Confirmation", "Login Successfully!");
//     getProgress();
//     });

//   }

//      void _showDoneDialog(BuildContext context,String Ti, String message) {
//    bool dialogOpen = true;

//     // Show the dialog
//     showDialog(
//       context: context,
//       builder: (context) => Confirmpopup(
//         title: Ti,
//         description: message,
//       ),
//     ).then((_) {
//       // When the dialog is dismissed manually, set dialogOpen to false
//       dialogOpen = false;
//     });

//     // Dismiss the dialog automatically after 2.5 seconds
//     Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
//       if (dialogOpen) {
//         Navigator.of(context).pop(); // Dismiss the dialog only if still open
//       }
//     });
// }
//   void showDialogSequence(BuildContext context) {
//     List<String> dialogQuestions = [
//       "How well did you sleep?",
//       "How was your nutrition?",
//       "How are you feeling today?"
//     ];

//     String selectedOption = "Good";

//     if (currentDialogIndex < dialogQuestions.length) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Dialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     return Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             dialogQuestions[currentDialogIndex],
//                             style: TextStyle(
//                               fontSize: constraints.maxWidth * 0.06,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Urbanist',
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: constraints.maxHeight * 0.05),
//                           ...["Excellent", "Good", "Normal", "Bad"]
//                               .map((option) {
//                             return Container(
//                               margin: EdgeInsets.symmetric(vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(197, 239, 230, 255),
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: option == selectedOption
//                                       ? const Color.fromARGB(255, 56, 199, 61)
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: RadioListTile(
//                                 title: Text(
//                                   option,
//                                   style: TextStyle(
//                                     fontFamily: 'Urbanist',
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 value: option,
//                                 groupValue: selectedOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedOption = value.toString();
//                                   });
//                                 },
//                                 activeColor: Colors.green,
//                               ),
//                             );
//                           }).toList(),
//                           SizedBox(height: constraints.maxHeight * 0.05),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF9747FF),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               minimumSize: Size(double.infinity, 50),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               if (currentDialogIndex <
//                                   dialogQuestions.length - 1) {
//                                 setState(() {
//                                   currentDialogIndex++;
//                                 });
//                                 showDialogSequence(context);
//                               } else {
//                                 setState(() {
//                                   currentDialogIndex = 0;
//                                 });
//                               }
//                             },
//                             child: Text(
//                               currentDialogIndex < dialogQuestions.length - 1
//                                   ? "Next"
//                                   : "Finish",
//                               style: TextStyle(
//                                 fontSize: constraints.maxWidth * 0.05,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Urbanist',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       );
//     } else {
//       setState(() {
//         currentDialogIndex = 0;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//                 child: Column(
//                   children: [
//                     UserScreen(

//                       onBackPressed: () {},
//                       maxWidth: constraints.maxWidth,
//                     ),
//                     SizedBox(height: constraints.maxWidth * 0.04),
//                     StreakCard(
//                       streakCount: 1,
//                       onExplore: () {
//                         showDialogSequence(context);
//                       },
//                       maxWidth: constraints.maxWidth,
//                     ),
//                     SizedBox(height: constraints.maxWidth * 0.04),
//                     MoodCard(
//                       mood: 'Happy',
//                       question: 'How was your day?',
//                       onEnterMood: () {
//                         print('Enter Mood tapped');
//                       },
//                       maxWidth: constraints.maxWidth,
//                     ),
//                     SizedBox(height: constraints.maxWidth * 0.04),

//                     CBTProgressCard(

//                       progress: progress,

//                       onEnterCBT: () {
//                         //ExampleScreen
//                            Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ExampleScreen(programs: [],),

//               ));
//                         print('Enter CBT tapped');
//                       },
//                       maxWidth: constraints.maxWidth,
//                     ),
//                     SizedBox(height: constraints.maxWidth * 0.04),
//                     ChatBotCard(
//                       onChatBotPressed: () {
//                         print('Open ChatBot tapped');
//                       },
//                       maxWidth: constraints.maxWidth,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: ActionBar(
//         selectedIndex: currentPageIndex,
//         onItemTapped: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => DashboardPage()),
//               );
//               break;
//               case 1:
//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ExampleScreen(programs: [],),

//               ));
//               case 2:

//                Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ExplorePage()),
//               );
//             case 3:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ChatbotstartScreen()),
//               );
//               break;
//              case 4:
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => ProfilePage()), // Pass the email as needed
//                );
//                break;
//             default:
//               // Handle other cases if necessary
//               break;
//           }
//         },
//       ),
//     );
//   }

// }

// class UserScreen extends StatefulWidget {

//    final VoidCallback onBackPressed;

//  final double maxWidth;
//  UserScreen({required this.onBackPressed, required this.maxWidth});

// @override
//   Header createState() => Header();
// }

// class Header extends State<UserScreen> {
// late VoidCallback onBackPressed;
// late double maxWidth;

//   @override
//   void initState() {
//     super.initState();

//     fetchUserName();

//     onBackPressed = widget.onBackPressed;
//     maxWidth = widget.maxWidth;

//   }

//   final String date;

//   Header() : date = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
// String userName='';
//   //final String date;
//   //final VoidCallback onBackPressed;
//   //final double maxWidth;

//  Future<void> fetchUserName() async {
//     try {

//       // Get the current user
//       final User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         // Fetch the name from Firestore (assuming user ID is used as document ID)
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid) // Use current user's UID as document ID
//             .get();

//         if (userDoc.exists) {
//           // Assuming the field name in Firestore is 'name'
//           setState(() {
//             userName = userDoc['name'] ?? 'No Name Available';
//           });
//         } else {
//           setState(() {
//             userName = 'User data not found';
//           });
//         }
//       } else {
//         setState(() {
//           userName = 'No authenticated user';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userName = 'Error fetching name';
//       });
//       print('Error fetching user name: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: maxWidth,
//       height: maxWidth * 0.65,
//       decoration: BoxDecoration(
//         color: Color(0xFF8B5CF6),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: maxWidth * 0.032,
//             left: maxWidth * 0.047,
//             right: maxWidth * 0.047,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Image.asset('Media/icons/dashboard.png'),
//                     SizedBox(width: maxWidth * 0.02),
//                     Text(
//                       'Home',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: maxWidth * 0.053,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NotificationScreen(),
//                           ),
//                         );
//                       },
//                       child: MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: Image.asset('Media/icons/bell-ring.png'),
//                       ),
//                     ),
//                     SizedBox(width: maxWidth * 0.03),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SettingsPage(),
//                           ),
//                         );
//                       },
//                       child: MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: Image.asset('Media/icons/setting.png'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: maxWidth * 0.17,
//             left: maxWidth * 0.047,
//             right: maxWidth * 0.047,
//             child: Row(
//               children: [
//                 Image.asset('Media/images/userr.png'),
//                 SizedBox(width: maxWidth * 0.02),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hello, $userName',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: maxWidth * 0.053,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: maxWidth * 0.001),
//                     Text(
//                       date,
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: maxWidth * 0.029,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: maxWidth * 0.000001,
//             right: maxWidth * 0.05,
//             child: Image.asset(
//               'Media/images/palm tree-pana.png',
//               width: 160,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Other card classes remain unchanged...

// class StreakCard extends StatelessWidget {
//   final int streakCount;
//   final VoidCallback onExplore;
//   final double maxWidth;

//   const StreakCard({
//     Key? key,
//     this.streakCount = 1,
//     required this.onExplore,
//     required this.maxWidth,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: maxWidth,
//       height: maxWidth * 0.35, // Increased height
//       decoration: BoxDecoration(
//         color: Color(0xFFF5F5FF),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: maxWidth * 0.05, // Slightly increased padding
//           vertical: maxWidth * 0.03,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Streak',
//                   style: TextStyle(
//                     fontFamily: 'Urbanist',
//                     fontSize: 20, // Increased font size
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFFA259FF),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: Text(
//                     '$streakCount',
//                     style: const TextStyle(
//                       fontFamily: 'Urbanist',
//                       fontSize: 24, // Increased font size
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFFA259FF),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6), // Increased spacing
//             const Text(
//               'consecutive days',
//               style: TextStyle(
//                 fontFamily: 'Urbanist',
//                 fontSize: 16, // Increased font size
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFFA259FF),
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: maxWidth * 0.25, // Increased width
//                   height: maxWidth * 0.07, // Increased height
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Color(0xFFA259FF),
//                   ),
//                   child: TextButton(
//                     onPressed: onExplore,
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       backgroundColor: Color(0xFFA259FF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: const Text(
//                       'Explore',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: 14, // Increased font size
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Image.asset(
//                   'Media/images/fire.png',
//                   width: maxWidth * 0.1, // Increased width
//                   height: maxWidth * 0.12, // Increased height
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MoodCard extends StatelessWidget {
//   final String mood;
//   final String question;
//   final VoidCallback onEnterMood;
//   final double maxWidth;

//   const MoodCard({
//     Key? key,
//     this.mood = 'Happy',
//     this.question = 'How was your day?',
//     required this.onEnterMood,
//     required this.maxWidth,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: maxWidth,
//       height: maxWidth * 0.35, // Increased height
//       decoration: BoxDecoration(
//         color: Color(0xFFFFF8E1),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: maxWidth * 0.05, // Slightly increased padding
//           vertical: maxWidth * 0.03,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Mood',
//                   style: TextStyle(
//                     fontFamily: 'Urbanist',
//                     fontSize: 18, // Increased font size
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFFFFCA28).withOpacity(0.8),
//                   ),
//                 ),
//                 Text(
//                   mood,
//                   style: const TextStyle(
//                     fontFamily: 'Urbanist',
//                     fontSize: 22, // Increased font size
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFFFFCA28),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6), // Increased spacing
//             Text(
//               question,
//               style: TextStyle(
//                 fontFamily: 'Urbanist',
//                 fontSize: 16, // Increased font size
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFFFFCA28).withOpacity(0.8),
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: maxWidth * 0.25, // Increased width
//                   height: maxWidth * 0.07, // Increased height
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Color(0xFFFFCA28),
//                   ),
//                   child: TextButton(
//                     onPressed: onEnterMood,
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       backgroundColor: Color(0xFFFFCA28),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: const Text(
//                       'Enter Mood',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: 14, // Increased font size
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Image.asset(
//                   'Media/images/growth.png',
//                   width: maxWidth * 0.12, // Increased width
//                   height: maxWidth * 0.12, // Increased height
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CBTProgressCard extends StatelessWidget {
//   final double progress;
//   final String title;
//   final String subtitle;
//   final VoidCallback? onEnterCBT;
//   final double maxWidth;

//   const CBTProgressCard({
//     Key? key,
//     this.progress = 1.0,
//     this.title = 'CBT Progress',
//     this.subtitle = 'Take a quick exercise!',
//     this.onEnterCBT,
//     required this.maxWidth,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: maxWidth,
//       height: maxWidth * 0.35, // Increased height
//       decoration: BoxDecoration(
//         color: Color(0xFFE6FFF4),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: maxWidth * 0.05, // Slightly increased padding
//           vertical: maxWidth * 0.03,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontFamily: 'Urbanist',
//                     fontSize: 18, // Increased font size
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF00D980),
//                   ),
//                 ),
//                 Text(
//                   '${(progress).toInt()}%',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 22, // Increased font size
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF00D980),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10), // Increased spacing
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontFamily: 'Urbanist',
//                 fontSize: 16, // Increased font size
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFF00D980),
//               ),
//             ),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: maxWidth * 0.25, // Increased width
//                   height: maxWidth * 0.07, // Increased height
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Color(0xFF00D980),
//                   ),
//                   child: TextButton(
//                     onPressed: onEnterCBT,
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       backgroundColor: Color(0xFF00D980),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: Text(
//                       'Enter CBT',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: 14, // Increased font size
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Image.asset(
//                   'Media/images/gene-therapy.png',
//                   width: maxWidth * 0.12, // Increased width
//                   height: maxWidth * 0.12, // Increased height
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatBotCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String description;
//   final VoidCallback onChatBotPressed;
//   final double maxWidth;

//   const ChatBotCard({
//     this.title = '3',
//     this.subtitle = 'Conversation',
//     this.description = 'TruYou Chat Wait For Ask All Day',
//     required this.onChatBotPressed,
//     required this.maxWidth,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: maxWidth,
//       height: maxWidth * 0.66, // Increased height
//       decoration: BoxDecoration(
//         color: Color(0xFFF5F3FF),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(maxWidth * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontFamily: 'Urbanist',
//                     fontSize: 40, // Increased font size
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Image.asset(
//                   'Media/images/chatbot.png',
//                   width: maxWidth * 0.25, // Increased width
//                   height: maxWidth * 0.25, // Increased height
//                 ),
//               ],
//             ),
//             // Increased spacing
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontFamily: 'Urbanist',
//                 fontSize: 18, // Increased font size
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             // Increased spacing
//             Text(
//               description,
//               style: TextStyle(
//                 fontFamily: 'Urbanist',
//                 fontSize: 14, // Increased font size
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFFC0B1E8),
//               ),
//             ),
//             Spacer(),
//             Container(
//               width: maxWidth * 0.5, // Increased width
//               height: maxWidth * 0.12, // Increased height
//               decoration: BoxDecoration(
//                 color: Color(0xFF9747FF),
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               ChatbotstartScreen()), // Replace with your screen
//                     );
//                   },
//                   borderRadius: BorderRadius.circular(10),
//                   child: Center(
//                     child: Text(
//                       'Open ChatBot',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: 16, // Increased font size
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truyou/Login-Sginup/Confirmpopup.dart';
import 'package:truyou/cbt/CBT_programs.dart';
import 'package:truyou/chatboot/chatstart.dart';
import 'package:truyou/explore/explore.dart';
import 'package:truyou/notification/notification.dart';
import 'package:truyou/profile/profilepage.dart';
import 'package:truyou/settingspages/mainpage.dart';
import 'package:truyou/actionBar/actionBar.dart'; // Import the ActionBar

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPageIndex = 0;
  int currentDialogIndex = 0;
  bool don = true;
  bool show_confirm = true;
  bool finish_daily_log = false;

  @override
  void initState() {
    super.initState();
    // Call _showDoneDialog when the page starts
    if (show_confirm && finish_daily_log == false && don == true) {
      finish_daily_log = true;
      show_confirm = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialogSequence(context);
      });
    }
  }

  void _showDoneDialog(BuildContext context, String Ti, String message) {
    bool dialogOpen = true;

    // Show the dialog
    showDialog(
      context: context,
      builder: (context) => Confirmpopup(
        title: Ti,
        description: message,
      ),
    ).then((_) {
      // When the dialog is dismissed manually, set dialogOpen to false
      dialogOpen = false;
    });

    // Dismiss the dialog automatically after 2.5 seconds
    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      if (dialogOpen) {
        Navigator.of(context).pop(); // Dismiss the dialog only if still open
      }
    });
  }

  Stream<double> getProgressStream() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return snapshot['progress'] ?? 0.0;
        }
        return 0.0;
      });
    }
    return Stream.value(0.0);
  }

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
                  borderRadius: BorderRadius.circular(20),
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
                                borderRadius: BorderRadius.circular(25),
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
                                    fontWeight: FontWeight.bold,
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
                              backgroundColor: Color(0xFF9747FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(double.infinity, 50),
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
              child: Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                child: Column(
                  children: [
                    UserScreen(
                      onBackPressed: () {},
                      maxWidth: constraints.maxWidth,
                    ),
                    SizedBox(height: constraints.maxWidth * 0.04),
                    StreakCard(
                      streakCount: 1,
                      onExplore: () {
                        // showDialogSequence(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExplorePage(),
                          ),
                        );
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
                    StreamBuilder<double>(
                      stream: getProgressStream(),
                      builder: (context, snapshot) {
                        double progress = snapshot.data ?? 0.0;
                        return CBTProgressCard(
                          progress: progress,
                          onEnterCBT: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ExampleScreen(programs: []),
                              ),
                            );
                            print('Enter CBT tapped');
                          },
                          maxWidth: constraints.maxWidth,
                        );
                      },
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
      bottomNavigationBar: ActionBar(
        selectedIndex: currentPageIndex,
        onItemTapped: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExampleScreen(programs: [])),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatbotstartScreen()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage()), // Pass the email as needed
              );
              break;
            default:
              // Handle other cases if necessary
              break;
          }
        },
      ),
    );
  }
}

class UserScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  final double maxWidth;
  UserScreen({required this.onBackPressed, required this.maxWidth});

  @override
  Header createState() => Header();
}

class Header extends State<UserScreen> {
  late VoidCallback onBackPressed;
  late double maxWidth;

  @override
  void initState() {
    super.initState();

    fetchUserName();

    onBackPressed = widget.onBackPressed;
    maxWidth = widget.maxWidth;
  }

  final String date;

  Header() : date = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
  String userName = '';

  Future<void> fetchUserName() async {
    try {
      // Get the current user
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch the name from Firestore (assuming user ID is used as document ID)
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Use current user's UID as document ID
            .get();

        if (userDoc.exists) {
          // Assuming the field name in Firestore is 'name'
          setState(() {
            userName = userDoc['name'] ?? 'No Name Available';
          });
        } else {
          setState(() {
            userName = 'User data not found';
          });
        }
      } else {
        setState(() {
          userName = 'No authenticated user';
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Error fetching name';
      });
      print('Error fetching user name: $e');
    }
  }

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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
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
            bottom: maxWidth * 0.000001,
            right: maxWidth * 0.05,
            child: Image.asset(
              'Media/images/palm tree-pana.png',
              width: 160,
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
    this.progress = 1.0,
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
                  '${(progress).toInt()}%',
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
    this.title = 'TruYou Chatbot',
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
                    fontSize: 25, // Increased font size
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatbotstartScreen()), // Replace with your screen
                    );
                  },
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
