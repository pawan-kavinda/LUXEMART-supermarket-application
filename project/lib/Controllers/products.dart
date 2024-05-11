import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/user_data.dart';

class productsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserData currentUserData = UserData();
  final _productstream =
      FirebaseFirestore.instance.collection('products').snapshots();

  Future<List<num>> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('products').get();
      List<num> userDataList =
          querySnapshot.docs.map((doc) => doc['price'] as num).toList();
      return userDataList;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
}
