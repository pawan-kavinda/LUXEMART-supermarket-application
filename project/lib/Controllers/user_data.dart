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

  Future<List<int>> getCurrentUserCartData() async {
    User? user = await FirebaseAuth.instance.currentUser;

    QuerySnapshot<Map<String, dynamic>> cartSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart')
        .get();

    List<int> cartPrices = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> productDoc
        in cartSnapshot.docs) {
      Map<String, dynamic>? productData = productDoc.data();
      dynamic price = productData?['price'];

      if (price != null) {
        cartPrices.add(price as int);
      }
    }

    return cartPrices;
  }

  Future<List<String>> getCurrentUserWhishListData() async {
    User? user = await FirebaseAuth.instance.currentUser;

    QuerySnapshot<Map<String, dynamic>> whishListSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('favourite')
            .get();

    List<String> whishListUid = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> productDoc
        in whishListSnapshot.docs) {
      Map<String, dynamic>? productData = productDoc.data();
      String productId = productDoc.id;

      whishListUid.add(productId);
    }

    return whishListUid;
  }
}
