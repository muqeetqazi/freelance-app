import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      await _firestore.collection('users').add({
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      throw Exception('Error saving user information: $e');
    }
  }
}
