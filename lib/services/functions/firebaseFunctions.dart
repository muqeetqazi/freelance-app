import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }

  static saveCompany(
      String name, String email, String uid, String industry) async {
    await FirebaseFirestore.instance.collection('companies').doc(uid).set({
      'email': email,
      'name': name,
      'industry': industry,
    });
  }
}
