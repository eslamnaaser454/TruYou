import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Navigation Button
            Padding(
              padding: const EdgeInsets.only(left: 23, top: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Image.asset(
                        'Media/icons/previous.png',
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Notification',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF393939),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            
            // Notification Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'Media/icons/notification.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Congratulations',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF393939),
                                ),
                              ),
                              // Text(
                              //   'Thursday, December 5, 2024',
                              //   style: TextStyle(
                              //     fontFamily: 'Urbanist',
                              //     fontSize: 10,
                              //     fontWeight: FontWeight.w400,
                              //     color: const Color(0xFF393939).withOpacity(0.5),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'you become one of truyou Users',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF393939).withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            // child: Text(
                            //   '3:02 pm',
                            //   style: TextStyle(
                            //     fontFamily: 'Urbanist',
                            //     fontSize: 10,
                            //     fontWeight: FontWeight.w400,
                            //     color: const Color(0xFF393939).withOpacity(0.5),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}