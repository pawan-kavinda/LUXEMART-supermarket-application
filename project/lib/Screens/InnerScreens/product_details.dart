// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Screens/InnerScreens/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  String title;
  int price;
  int discountPrice;
  String imgUrl;
  String category;
  ProductDetailsScreen(
      {required this.title,
      required this.price,
      required this.discountPrice,
      required this.imgUrl,
      required this.category});

  bool isVegitable = false;

  @override
  Widget build(BuildContext context) {
    if (category == 'Vegitables') {
      isVegitable = true;
    }

    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          // detail header
          detailItemsHeader(),
          // for image
          detailImage(),
          Container(
            color: Color.fromARGB(255, 252, 251, 251),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              !isVegitable ? title : '${title}/1Kg',
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 34),
                            ),
                          ),
                          // For price
                          Center(
                            child: Text(
                              'Rs.${price}.00',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // For items quantity
                    Material(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    )
                  ],
                ),

                SizedBox(
                  height: 27,
                ),

                Center(
                  child: RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),

                // For description
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Indulge in the goodness of nature with our Gourmet Harvest Organic Quinoa Blend. Crafted with care, this blend combines the earthy flavors of organic and colorful vegetables.",
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                // For add to cart button
                const SizedBox(
                  height: 25,
                ),
                Material(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 21),
                      child: const Text(
                        "Add to Cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 254, 254, 254),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox detailImage() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 0, 0, 0)!,
                      blurRadius: 15,
                      offset: const Offset(0, 10))
                ],
                borderRadius: BorderRadius.circular(250),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250),
                child: Image.network(
                  imgUrl,
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding detailItemsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Material(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.21),
            borderRadius: BorderRadius.circular(10),
            child: const BackButton(
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            "Product Details",
            style: GoogleFonts.aBeeZee(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Material(
            color: Colors.white.withOpacity(0.21),
            borderRadius: BorderRadius.circular(10),
          )
        ],
      ),
    );
  }
}
