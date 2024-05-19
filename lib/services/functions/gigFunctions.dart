import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GigFunction {
  static Future<List<DocumentSnapshot>> getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    return querySnapshot.docs;
  }

  Future<List<DocumentSnapshot>> fetchGigsByCategory(String categoryId) async {
    print('categoryId: $categoryId'); // Debugging statement
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('gigs')
        .where('catId', isEqualTo: categoryId)
        .where('available', isEqualTo: true)
        .get();

    List<DocumentSnapshot> gigs = querySnapshot.docs;

    print('Fetched gigs: $gigs'); // Debugging statement
    return gigs;
  }

  Future<String> getCategoryName(String categoryId) async {
    DocumentSnapshot categoryDoc = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .get();

    if (categoryDoc.exists) {
      return categoryDoc['catNm'];
    } else {
      return '';
    }
  }

  static Future<bool> createGig(
    String categoryId,
    String description,
    bool isAvailable,
  ) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('gigs')
              .where('userId', isEqualTo: userId)
              .where('catId', isEqualTo: categoryId)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return false;
      }

      await FirebaseFirestore.instance.collection('gigs').add({
        'available': isAvailable,
        'catId': categoryId,
        'gigDescription': description,
        'userId': userId,
      });

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<DocumentSnapshot>> getGigsForUser() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('gigs')
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs;
  }

  static Future<void> updateGigAvailability(String gigId, bool isActive) async {
    await FirebaseFirestore.instance.collection('gigs').doc(gigId).update({
      'available': isActive,
    });
  }

  static Future<void> deleteGig(String gigId) async {
    await FirebaseFirestore.instance.collection('gigs').doc(gigId).delete();
  }
}
