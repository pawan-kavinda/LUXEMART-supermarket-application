import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/user_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final _cartProductStream = FirebaseFirestore.instance.collection('users');

  UserData currentUser = new UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              _cartProductStream.doc(user!.uid).collection('cart').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading....');
            }
            var docs = snapshot.data;

            if (docs == null || docs.docs.isEmpty) {
              return const Text('No cart items found');
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
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Column(children: [
                          Image.asset(
                            'assets/Images/beauty.jpg',
                            height: 80,
                            fit: BoxFit.fill,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(price.toString()),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete),
                                ),

                                // GestureDetector(
                                //     onTap: () {
                                //       favouriteItems.returntitle(title);
                                //       favouriteItems.returnPrice(discountprice);
                                //       favouriteItems.returnImg(imgUrl);
                                //     },
                                //     child: Icon(
                                //       IconlyLight.heart,
                                //       size: 22,
                                //     ))
                              ],
                            ),
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

                          // SizedBox(
                          //   width: double.infinity,
                          //   child: TextButton(
                          //     onPressed: () async {
                          //       User? user = FirebaseAuth.instance.currentUser;

                          //       await FirebaseFirestore.instance
                          //           .collection('users')
                          //           .doc(user!.uid)
                          //           .collection('cart')
                          //           .add(data);

                          //       // cartItems.returntitle(title);
                          //       // cartItems.returnPrice(discountprice);
                          //       // cartItems.returnImg(imgUrl);
                          //     },
                          //     child: Text(
                          //       "Add to cart",
                          //       maxLines: 1,
                          //       style: TextStyle(fontSize: 15),
                          //     ),
                          //   style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all(
                          //           Theme.of(context).cardColor),
                          //       tapTargetSize:
                          //           MaterialTapTargetSize.shrinkWrap,
                          //       shape: MaterialStateProperty.all<
                          //               RoundedRectangleBorder>(
                          //           RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.only(
                          //                   bottomLeft: Radius.circular(12.0),
                          //                   bottomRight:
                          //                       Radius.circular(12.0))))),
                          // ),
                          // )
                        ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
