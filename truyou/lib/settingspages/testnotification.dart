import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addNotification({
  required String title,
  required String body,
  required String type, // 'mood' or 'activity'
  required String userId,
}) async {
  try {
    // Reference to the Firestore collection
    CollectionReference notifications =
        FirebaseFirestore.instance.collection('notifications');

    // Add a new notification
    await notifications.add({
      'title': title,
      'body': body,
      'type': type, // 'mood' or 'activity'
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false, // Default to unread
    });

    print("Notification added successfully.");
  } catch (e) {
    print("Error adding notification: $e");
  }
}
