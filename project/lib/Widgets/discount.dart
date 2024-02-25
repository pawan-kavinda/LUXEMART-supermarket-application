// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/user_data.dart';

class Discount extends StatefulWidget {
  const Discount({super.key});

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  final _productstream =
      FirebaseFirestore.instance.collection('products').snapshots();
  UserData currentUser = new UserData();

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
            //to get discount products
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

            return Container(
              height: 200,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 400 / 360),
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

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).cardColor,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Column(children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/Images/beauty.jpg',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.fill,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.heart_broken,
                                      size: 18,
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          title,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 13),
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
                            Row(
                              children: [
                                Text(
                                  'Rs.${discountPrice.toString()}',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text('Rs.${price.toString()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            //Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;

                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .collection('cart')
                                      .add(data);

                                  // cartItems.returntitle(title);
                                  // cartItems.returnPrice(discountprice);
                                  // cartItems.returnImg(imgUrl);
                                },
                                child: Text(
                                  "Add to cart",
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 15),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).cardColor),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(12.0),
                                                bottomRight:
                                                    Radius.circular(12.0))))),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                    //else {
                    //   return Container();
                    // }
                  }),
            );
          }),
    );
  }
}
