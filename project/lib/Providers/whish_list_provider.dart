// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Controllers/user_data.dart';

class WhishListProvider extends ChangeNotifier {
  String? userId = FirebaseAuth.instance.currentUser!.uid;
  List<bool> issLiked = List.generate(100, (index) => false);

  // Future<void> issfvlist(String userId) async {
  //   QuerySnapshot allProductsSnapshot =
  //       await FirebaseFirestore.instance.collection('products').get();
  //   List<String> allProductTitles =
  //       allProductsSnapshot.docs.map((doc) => doc['title'] as String).toList();

  //   QuerySnapshot favoriteProductsSnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('favourite')
  //       .get();

  //   List<String> favoriteProductTitles = favoriteProductsSnapshot.docs
  //       .map((doc) => doc['title'] as String)
  //       .toList();

  //   // Initialize the issLiked list with false for all products
  //   List<bool> issLiked =
  //       List.generate(allProductTitles.length, (index) => false);

  //   // Iterate through favoriteProductTitles
  //   for (String title in favoriteProductTitles) {
  //     // Find the index of the title in allProductTitles
  //     int index = allProductTitles.indexOf(title);
  //     // If the title is found, set the corresponding value in issLiked to true
  //     if (index != -1) {
  //       issLiked[index] = true;
  //     }
  //   }

  // }

  List<bool> isLikedList = [false, false, false, false, false];

  //check weather product is in favourite list
  Future<bool> isProductInFavorites(
      String userId, Map<String, dynamic> productData, int index) async {
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: productData['title'])
        .get();

    notifyListeners();

    return favorites.docs.isNotEmpty;
  }

  //for feed items
  Future<void> addFeedProductsToFavourite(
      String uid, Map<String, dynamic> data, int index) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favourite')
      ..add(data);

    issLiked[index] = true;
    notifyListeners();
  }

  Future<void> removeFeedProductFromFavorites(
      String userId, Map<String, dynamic> productData, int index) async {
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: productData['title'])
        .get();
    issLiked[index] = false;
    for (QueryDocumentSnapshot doc in favorites.docs) {
      await doc.reference.delete();
    }

    notifyListeners();
  }
///////////////////////////////////////////////////////////////////////
  //for discount items

  Future<void> addDiscountProductsToFavourite(
      String uid, Map<String, dynamic> data, int index) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favourite')
      ..add(data);

    isLikedList[index] = true;
    notifyListeners();
  }

  Future<void> removeDiscountProductFromFavorites(
      String userId, Map<String, dynamic> productData, int index) async {
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: productData['title'])
        .get();
    isLikedList[index] = false;
    for (QueryDocumentSnapshot doc in favorites.docs) {
      await doc.reference.delete();
    }

    notifyListeners();
  }

//////////////////////////////////////////////////

  List<bool> initializeIsLikedList() {
    isLikedList = List<bool>.filled(5, false);
    //notifyListeners();
    return isLikedList;
  }

  void updateIsLiked(int index, bool isLiked) {
    isLikedList[index] = isLiked;
    notifyListeners();
  }

  Future<bool> isInWhishList(String userId, String title) async {
    bool whishlist = false;
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: title)
        .get();
    if (favorites.docs.isEmpty) {
      notifyListeners();
      return whishlist;
    } else {
      notifyListeners();
      return !whishlist;
    }
  }

  Future<List<DocumentSnapshot>> getFavorites() async {
    try {
      QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favourite')
          .get();
      notifyListeners();
      return favoritesSnapshot.docs;
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }

  Future<bool> isProductInFavoriteList(String title) async {
    List<DocumentSnapshot> favorites = await getFavorites();
    return favorites.any((doc) {
      var data = doc.data() as Map<String, dynamic>?;
      // Explicit casting
      return data?['title'] == title;
    });
  }
}
