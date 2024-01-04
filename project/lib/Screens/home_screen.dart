// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:project/Widgets/on_sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _Images = [
    'assets/Images/one.jpg',
    'assets/Images/two.jpg',
    'assets/Images/three.jpg',
    'assets/Images/four.jpg',
  ];

  final List<String> _FeaturedImages = [
    'assets/Images/cabbage.jpg',
    'assets/Images/carrot.jpg',
    'assets/Images/onion.jpg',
    'assets/Images/chicken.jpg',
    'assets/Images/anchor.jpg',
  ];

  final List<String> _DiscountPrice = [
    "Rs.50",
    "Rs.60",
    "Rs.70",
    "Rs.500",
    "rs250"
  ];
  final List<String> _Price = ["Rs.80", "Rs.66", "Rs.80", "Rs.600", "rs300"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Icon(Icons.shopping_cart)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Swiper(
                  itemCount: _Images.length,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      _Images[index],
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "FEATURED PRODUCTS",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: AutofillHints.familyName,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  itemCount: _FeaturedImages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return OnSaleWidget(
                      image: _FeaturedImages[index],
                      price: _Price[index],
                      discount_price: _DiscountPrice[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ALL PRODUCTS",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: AutofillHints.familyName,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 250 / 300,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(5, (index) {
                  return OnSaleWidget(
                    image: _FeaturedImages[index],
                    price: _Price[index],
                    discount_price: _DiscountPrice[index],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
