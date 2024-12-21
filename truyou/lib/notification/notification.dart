import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 360,
        height: 668,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  Image.asset(
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZdReggc5tgnd',
                    width: 34,
                    height: 34,
                  ),
                  const SizedBox(width: 12),
                  Text(
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
            const SizedBox(height: 31),
            // Notification Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                children: [
                  _buildNotificationCard(
                    'Congratulations',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZdReggc5tgne',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZdReggc5tgnf',
                  ),
                  const SizedBox(height: 15),
                  _buildNotificationCard(
                    'Notification 2',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZdReggc5tgng',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZtReggc5tgnh',
                  ),
                  const SizedBox(height: 15),
                  _buildNotificationCard(
                    'Notification 3',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZtReggc5tgni',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZtReggc5tgnj',
                  ),
                  const SizedBox(height: 15),
                  _buildNotificationCard(
                    'Notification 4',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZtReggc5tgnk',
                    'https://dashboard.codeparrot.ai/api/assets/Z2NIZtReggc5tgnl',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String title, String iconPath, String bgPath) {
    return Container(
      width: 315,
      height: 76,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(bgPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 25,
              height: 25,
            ),
            const SizedBox(width: 9),
            Expanded(
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
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF393939),
                        ),
                      ),
                      Text(
                        'Thursday, December 5, 2024',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Color(0x80393939),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'User22  you become one of truyou Users',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0x80393939),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '3:02 pm',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0x80393939),
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

