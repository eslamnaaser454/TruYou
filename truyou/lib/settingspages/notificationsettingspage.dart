import 'package:flutter/material.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool moodBasedNotify = true;
  bool activityBasedNotify = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: 16),
              // Header
              const Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 23),
                      child:
                          Image(image: AssetImage("Media/icons/previous.png"))),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Notification Setting',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF393939),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 34), // Balance the back button
                ],
              ),
              SizedBox(height: 24),
              // Main Container
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Mood Based Notify
                      Container(
                        width: double.infinity,
                        height: 45,
                        margin: EdgeInsets.symmetric(vertical: 7.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications,
                                size: 18,
                                color: Color(0xFFA259FF),
                              ),
                              SizedBox(width: 14),
                              const Text(
                                'Mood Based Notify',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF393939),
                                ),
                              ),
                              Spacer(),
                              Switch(
                                value: moodBasedNotify,
                                onChanged: (value) {
                                  setState(() {
                                    moodBasedNotify = value;
                                  });
                                },
                                activeColor: Colors.purple,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Activity Based Notify
                      Container(
                        width: double.infinity,
                        height: 45,
                        margin: EdgeInsets.symmetric(vertical: 7.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications,
                                size: 18,
                                color: Color(0xFFA259FF),
                              ),
                              SizedBox(width: 14),
                              const Text(
                                'Activity Based Notify',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Switch(
                                value: activityBasedNotify,
                                onChanged: (value) {
                                  setState(() {
                                    activityBasedNotify = value;
                                  });
                                },
                                activeColor: Colors.purple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
