import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Stream<QuerySnapshot> getCityDocuments(String uid) {
    print('Stream ' + uid);
    return _db.collection(uid).snapshots();
  }

  Future<void> deleteCityDocument({String cityName,String uid}) async {
    print("Delete" + uid);
    return await _db
        .collection(uid)
        .doc(cityName)
        .delete()
        .then((value) => print('Done'))
        .catchError((error) => print("Failed to delete: $error"));
  }

  Future<void> addAddressDocument({String cityName,String uid}) async {
    _db.collection(uid).doc(cityName).set({
      "City": cityName,
    });
  }
}
