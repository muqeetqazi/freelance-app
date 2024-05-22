import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<List<DocumentSnapshot>> fetchAllGigs() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('gigs').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching all gigs: $e');
      return [];
    }
  }

  static Future<bool> createGig(
    String categoryId,
    String description,
    bool isAvailable,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    if (userEmail == null) {
      return false;
    }

    try {
      DocumentReference gigRef =
          FirebaseFirestore.instance.collection('gigs').doc();

      await gigRef.set({
        'available': isAvailable,
        'catId': categoryId,
        'gigDescription': description,
        'userId': userEmail,
      });

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<DocumentSnapshot>> getGigsForUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    if (userEmail == null) {
      return [];
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('gigs')
        .where('userId', isEqualTo: userEmail)
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
