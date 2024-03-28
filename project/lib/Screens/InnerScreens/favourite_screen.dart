// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/user_data.dart';
import 'package:project/Providers/whish_list_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  User? user = FirebaseAuth.instance.currentUser;
  final _cartProductStream = FirebaseFirestore.instance.collection('users');

  UserData currentUser = new UserData();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WhishListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text('Favourite Screen'),
        ),
        backgroundColor: Colors.lightGreenAccent,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
      ),
      body: StreamBuilder(
          stream: _cartProductStream
              .doc(user!.uid)
              .collection('favourite')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading....');
            }
            var docs = snapshot.data;

            if (docs == null || docs.docs.isEmpty) {
              return Center(
                  child: const Text(
                'Whishlist is Empty',
                style: TextStyle(fontSize: 30),
              ));
            }

            List<Map<String, dynamic>> cartItems =
                docs.docs.map((doc) => doc.data()).toList();

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 800 / 360),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = cartItems[index];

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
                    padding: const EdgeInsets.all(15.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Row(children: [
                          Image.network(
                            imgUrl,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 1),
                                  child: Container(
                                    width: 80,
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 30),
                                  child: Container(
                                    width: 100,
                                    child: Text(
                                      'Rs.${price.toString()}.00',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              // await FirebaseFirestore.instance
                              //     .collection('users')
                              //     .doc(user!.uid)
                              //     .collection('favourite')
                              //     .doc(docs.docs[index].id)
                              //     .delete();
                              await provider.removeProductFromFavorites(
                                  user!.uid, data, index);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // PriceWidget(
                                //   isOnSale: true,
                                //   price: price,
                                //   salePrice: discountprice,
                                //   textPrice: _quantityTextController.text,
                                // ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ]),
                        // child: Column(children: [
                        //   Image.asset(
                        //     'assets/Images/beauty.jpg',
                        //     height: 80,
                        //     fit: BoxFit.fill,
                        //   ),

                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 50, vertical: 5),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           title,
                        //           style: TextStyle(fontSize: 13),
                        //         ),
                        //         Text(price.toString()),
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(Icons.delete),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         // PriceWidget(
                        //         //   isOnSale: true,
                        //         //   price: price,
                        //         //   salePrice: discountprice,
                        //         //   textPrice: _quantityTextController.text,
                        //         // ),
                        //         SizedBox(
                        //           width: 8,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   Spacer(),

                        // ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
