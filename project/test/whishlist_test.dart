// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:project/Providers/whish_list_provider.dart';

// import 'package:firebase_core/firebase_core.dart';

// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// void main() {
//   late WhishListProvider wishListProvider;
//   late MockFirebaseFirestore mockFirestore;

//   setUpAll(() async {
//     await Firebase.initializeApp();
//   });

//   setUp(() {
//     mockFirestore = MockFirebaseFirestore();
//     wishListProvider = WhishListProvider();
//   });

//   test('Add to wishlist', () async {
//     final Map<String, dynamic> productData = {
//       'title': 'Test Product',
//     };

//     await wishListProvider.addToFavourite('userId', productData, 0);

//     expect(wishListProvider.isLikedList[0], true);
//   });

//   test('Remove from wishlist', () async {
//     final Map<String, dynamic> productData = {
//       'title': 'Test Product',
//     };

//     await wishListProvider.addToFavourite('userId', productData, 0);

//     await wishListProvider.removeProductFromFavorites('userId', productData, 0);

//     expect(wishListProvider.isLikedList[0], false);
//   });
// }
