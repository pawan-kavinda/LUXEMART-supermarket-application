import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Controllers/products.dart';
import 'package:project/Controllers/user_data.dart';
import 'package:project/Providers/whish_list_provider.dart';
import 'package:project/Screens/InnerScreens/product_details.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:responsive_framework/responsive_framework.dart";

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
    final provider = Provider.of<WhishListProvider>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 600 ? 2 : 4,
              childAspectRatio: (screenWidth < 600 ? 300 : 150) / 360,
            ),
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
              String category =
                  data.containsKey('category') ? data['category'] : '';
              int quantity =
                  data.containsKey('quantity') ? data['quantity'] : 1;
              String? userId = FirebaseAuth.instance.currentUser!.uid;
              bool islikeditem = false;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 239, 250, 240),
                        border: Border.all(color: Colors.black, width: 0.1),
                      ),
                      child: InkWell(
                        highlightColor: Colors.blue.withOpacity(0.4),
                        splashColor: Colors.lightGreenAccent.withOpacity(0.4),
                        onTap: () {
                          Get.to(
                            ProductDetailsScreen(
                              title: title,
                              price: price,
                              discountPrice: discountPrice,
                              imgUrl: imgUrl,
                              category: category,
                            ),
                            transition: Transition.zoom,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imgUrl,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      height: screenHeight *
                                          0.1, // Adjust height dynamically
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      User? user =
                                          FirebaseAuth.instance.currentUser;
                                      bool isAlreadyInFavorites = await provider
                                          .isInWhishList(user!.uid, title);

                                      if (!isAlreadyInFavorites) {
                                        provider.addFeedProductsToFavourite(
                                            user.uid, data, index);
                                      } else {
                                        provider.removeFeedProductFromFavorites(
                                            userId, data, index);
                                      }
                                    },
                                    child: Icon(
                                      provider.issLiked[index]
                                          ? IconlyBold.heart
                                          : IconlyLight.heart,
                                      size: 22,
                                      color: provider.issLiked[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.3,
                                    child: Center(
                                      child: Text(
                                        title,
                                        style: GoogleFonts.lato(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      IconlyBold.plus,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
