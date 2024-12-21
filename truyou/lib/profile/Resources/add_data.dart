import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreData {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> saveData({
    required String name,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      // Upload the image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('profileImages/$fileName');
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save user data to Firestore
      await _firestore.collection('users').add({
        'name': name,
        'bio': bio,
        'profileImageUrl': downloadUrl,
      });

      return 'Success';
    } catch (e) {
      print('Error saving data: $e');
      return 'Error saving data';
    }
  }
}
