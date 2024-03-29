// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:project/Controllers/user_data.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({super.key});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _productstream =
      FirebaseFirestore.instance.collection('products').snapshots();
  UserData currentUser = new UserData();
  List isLiked = List.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _productstream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading....');
            }
            var docs = snapshot.data!.docs;

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 330 / 360),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  String imgUrl =
                      data.containsKey('imageurl') ? data['imageurl'] : '';
                  String title = data.containsKey('title') ? data['title'] : '';
                  int price = data.containsKey('price')
                      ? int.tryParse(data['price'].toString()) ?? 0
                      : 0;
                  int discountPrice = data.containsKey('discountprice')
                      ? int.tryParse(data['discountprice'].toString()) ?? 0
                      : 0;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                      child: InkWell(
                        highlightColor: Colors.blue.withOpacity(0.4),
                        splashColor: Colors.lightGreenAccent.withOpacity(0.4),
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          imgUrl,
                                          height: 80,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            User? user = FirebaseAuth
                                                .instance.currentUser;
                                            bool isAlreadyInFavorites =
                                                await isProductInFavorites(
                                                    user!.uid, data);
                                            //if product not in favourite yet
                                            if (!isAlreadyInFavorites) {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(user!.uid)
                                                  .collection('favourite')
                                                ..add(data);
                                            } else {
                                              //if it is in gavourite remove it
                                              removeProductFromFavorites(
                                                  user!.uid, data);
                                            }

                                            setState(() {
                                              isLiked[index] = !isLiked[index];
                                            });
                                          },
                                          child: Icon(
                                            isLiked[index]
                                                ? IconlyBold.heart
                                                : IconlyLight.heart,
                                            size: 22,
                                            color: isLiked[index]
                                                ? Colors.red
                                                : null,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        title,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0),
                                    child: Text('Rs.${price.toString()}'),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    color: Colors.green,
                                    onPressed: () async {
                                      User? user =
                                          FirebaseAuth.instance.currentUser;

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .collection('cart')
                                          .add(data);
                                    },
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28.0),
                                      child: Icon(IconlyBold.plus),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Future<bool> isProductInFavorites(
      String userId, Map<String, dynamic> productData) async {
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: productData['title'])
        // Add more conditions if needed for uniqueness
        .get();

    return favorites.docs.isNotEmpty;
  }

  Future<void> removeProductFromFavorites(
      String userId, Map<String, dynamic> productData) async {
    QuerySnapshot favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .where('title', isEqualTo: productData['title'])
        .get();

    for (QueryDocumentSnapshot doc in favorites.docs) {
      await doc.reference.delete();
    }
  }
}
