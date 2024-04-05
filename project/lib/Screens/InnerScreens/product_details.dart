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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 131, 232, 200),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "PRODUCT DETAILS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.normal),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              width: 8,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          width: 300,
          height: 630,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  title,
                  style: GoogleFonts.tienne(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Image.network(
                imgUrl,
                width: 200,
                height: 200,
              ),
              RatingBar.builder(
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  isVegitable
                      ? 'Rs.${price.toString()}.00/per 1Kg'
                      : 'Rs.${price.toString()}.00',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Indulge in the goodness of nature with our Gourmet Harvest Organic Quinoa Blend. Crafted with care, this blend combines the earthy flavors of organic and colorful vegetables.",
                  style: GoogleFonts.lato(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
