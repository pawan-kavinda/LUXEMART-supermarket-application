import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Controllers/user_data.dart';

class productsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserData currentUserData = UserData();

  Future<List<num>> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('products').get();
      List<num> userDataList =
          querySnapshot.docs.map((doc) => doc['price'] as num).toList();
      return userDataList;
    } catch (e) {
      print("Error fetching data: $e");
      return []; // Return an empty list or handle the error according to your needs
    }
  }
}
