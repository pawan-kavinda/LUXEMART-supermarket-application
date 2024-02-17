import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  Future<Map<String, dynamic>> getCurrentUserData() async {
    User? user = await FirebaseAuth.instance.currentUser;

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user!.uid)
        .get();

    Map<String, dynamic>? userData = snapshot.data();

    return userData ?? {};
  }
}
