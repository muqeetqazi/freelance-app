import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreHelper {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  FirestoreHelper._();

  static final FirestoreHelper _singleObj = FirestoreHelper._();
  static bool _isFirstTime = true;

  static Future<FirestoreHelper> getInstance() async {
    if (_isFirstTime) {
      await Firebase.initializeApp();
      _isFirstTime = false;
    }
    return _singleObj;
  }

  Future<Map<String, dynamic>> getUserProfile(String email) async {
    var docRef = _firestoreInstance.collection("users").doc(email);

    var doc = await docRef.get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    }
    return {};
  }
}
