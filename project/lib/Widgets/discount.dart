// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Controllers/user_data.dart';
import 'package:project/Providers/whish_list_provider.dart';
import 'package:project/Screens/InnerScreens/product_details.dart';
import 'package:provider/provider.dart';

class Discount extends StatefulWidget {
  const Discount({super.key});

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  final _productstream =
      FirebaseFirestore.instance.collection('products').snapshots();
  UserData currentUser = new UserData();

  List<bool> isLiked = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WhishListProvider>(context);
    isLiked = provider.isLikedList;
    final screenWidth = MediaQuery.of(context).size.width;

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
            // to get discount products
            var filteredDocs = docs.where((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              int price = data.containsKey('price')
                  ? int.tryParse(data['price'].toString()) ?? 0
                  : 0;
              int discountPrice = data.containsKey('discountPrice')
                  ? int.tryParse(data['discountPrice'].toString()) ?? 0
                  : 0;
              return price != discountPrice;
            }).toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 250,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio:
                            screenWidth < 600 ? 380 / 360 : 380 / 300),
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          filteredDocs[index].data() as Map<String, dynamic>;

                      String imgUrl =
                          data.containsKey('imageurl') ? data['imageurl'] : '';
                      String title =
                          data.containsKey('title') ? data['title'] : '';
                      int price = data.containsKey('price')
                          ? int.tryParse(data['price'].toString()) ?? 0
                          : 0;
                      int discountPrice = data.containsKey('discountPrice')
                          ? int.tryParse(data['discountPrice'].toString()) ?? 0
                          : 0;
                      String category =
                          data.containsKey('category') ? data['category'] : '';

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).cardColor,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                    color: Colors.black, width: 0.1)),
                            child: InkWell(
                              splashColor: Color.fromARGB(255, 214, 240, 100),
                              onTap: () {
                                Get.to(
                                    ProductDetailsScreen(
                                      title: title,
                                      price: price,
                                      discountPrice: discountPrice,
                                      imgUrl: imgUrl,
                                      category: category,
                                    ),
                                    transition: Transition.zoom);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: imgUrl,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: GestureDetector(
                                            onTap: () async {
                                              User? user = FirebaseAuth
                                                  .instance.currentUser;
                                              bool isAlreadyInFavorites =
                                                  await provider
                                                      .isProductInFavorites(
                                                          user!.uid,
                                                          data,
                                                          index);

                                              // if product not in favourite yet
                                              if (!isAlreadyInFavorites) {
                                                provider
                                                    .addDiscountProductsToFavourite(
                                                        user.uid, data, index);
                                              } else {
                                                // if it is in favourite remove it
                                                provider
                                                    .removeDiscountProductFromFavorites(
                                                        user!.uid, data, index);
                                              }
                                            },
                                            child: Icon(
                                              provider.isLikedList[index]
                                                  ? IconlyBold.heart
                                                  : IconlyLight.heart,
                                              size: 22,
                                              color: provider.isLikedList[index]
                                                  ? Colors.red
                                                  : null,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              width:
                                                  screenWidth < 600 ? 120 : 160,
                                              child: Center(
                                                child: Text(
                                                  title,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Rs.${discountPrice.toString()}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10.0,
                                        ),
                                        child: Text('Rs.${price.toString()}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
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
                                        icon: Icon(IconlyBold.plus),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}
