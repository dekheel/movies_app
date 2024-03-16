import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchWatchlistItems() async {
  List<Map<String, dynamic>> watchlistItems = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('watchlist')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        watchlistItems.add(doc.data());
      });
    }
  } catch (e) {
    print('Error  watchlist items: $e');
  }
  return watchlistItems;
}
