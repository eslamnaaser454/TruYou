import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationSetting extends StatefulWidget {
  final String userId; // Pass the userId when navigating to this page
  const NotificationSetting({Key? key, required this.userId}) : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool moodBasedNotify = true;
  bool activityBasedNotify = true;

  @override
  void initState() {
    super.initState();
    _fetchSettings();
  }

  Future<void> _fetchSettings() async {
    Map<String, bool> settings = await fetchNotificationSettings(widget.userId);
    setState(() {
      moodBasedNotify = settings['moodNotifications']!;
      activityBasedNotify = settings['activityNotifications']!;
    });
  }

  Future<void> _updateSetting(String field, bool value) async {
    setState(() {
      if (field == 'moodNotifications') {
        moodBasedNotify = value;
      } else if (field == 'activityNotifications') {
        activityBasedNotify = value;
      }
    });
    await updateNotificationSetting(widget.userId, field, value);
  }

  Future<void> addNotification({
    required String title,
    required String body,
    required String type, // 'mood' or 'activity'
    required String userId,
  }) async {
    try {
      CollectionReference notifications =
          FirebaseFirestore.instance.collection('notifications');

      await notifications.add({
        'title': title,
        'body': body,
        'type': type,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false, // Default to unread
      });

      print("Notification added successfully.");
    } catch (e) {
      print("Error adding notification: $e");
    }
  }

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
              const SizedBox(height: 16),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, size: 24),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Notification Setting',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF393939),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 34),
                ],
              ),
              const SizedBox(height: 24),
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
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                              const SizedBox(width: 14),
                              const Text(
                                'Mood Based Notify',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF393939),
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: moodBasedNotify,
                                onChanged: (value) {
                                  _updateSetting('moodNotifications', value);
                                },
                                inactiveThumbColor: const Color(0xFFA259FF),
                                activeColor: const Color(0xFFA259FF),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Activity Based Notify
                      Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                              const SizedBox(width: 14),
                              const Text(
                                'Activity Based Notify',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: activityBasedNotify,
                                onChanged: (value) {
                                  _updateSetting(
                                      'activityNotifications', value);
                                },
                                inactiveThumbColor: const Color(0xFFA259FF),
                                activeColor: const Color(0xFFA259FF),
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

  Future<Map<String, bool>> fetchNotificationSettings(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return {
          'moodNotifications': data['moodNotifications'] ?? true,
          'activityNotifications': data['activityNotifications'] ?? true,
        };
      } else {
        return {'moodNotifications': true, 'activityNotifications': true};
      }
    } catch (e) {
      print("Error fetching settings: $e");
      return {'moodNotifications': true, 'activityNotifications': true};
    }
  }

  Future<void> updateNotificationSetting(
      String userId, String field, bool value) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({field: value});
      print("$field updated to $value");
    } catch (e) {
      print("Error updating $field: $e");
    }
  }
}
