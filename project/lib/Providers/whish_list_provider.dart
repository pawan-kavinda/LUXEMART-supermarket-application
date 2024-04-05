// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Controllers/user_data.dart';

class WhishListProvider extends ChangeNotifier {
  List<bool> isLikedList = [false, false, false, false, false];
  List<bool> issLiked = List.generate(100, (index) => false);
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

  Future<void> addToFavourite(
      String uid, Map<String, dynamic> data, int index) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favourite')
      ..add(data);

    isLikedList[index] = true;
    notifyListeners();
  }

  Future<void> removeProductFromFavorites(
      String userId, Map<String, dynamic> productData, int index) async {
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: productData['title'])
        .get();

    for (QueryDocumentSnapshot doc in favorites.docs) {
      await doc.reference.delete();
    }
    isLikedList[index] = false;
    notifyListeners();
  }

  List<bool> initializeIsLikedList() {
    isLikedList = List<bool>.filled(5, false);
    //notifyListeners();
    return isLikedList;
  }

  void updateIsLiked(int index, bool isLiked) {
    isLikedList[index] = isLiked;
    notifyListeners();
  }
}
