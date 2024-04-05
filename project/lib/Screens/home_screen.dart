// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Screens/InnerScreens/cart_screen.dart';
import 'package:project/Widgets/discount.dart';
import 'package:project/Widgets/feed_widget.dart';
import 'package:blinking_text/blinking_text.dart';

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
        leading: Image.asset(
          'assets/Images/carrot.jpg',
        ),
        title: Row(children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: GoogleFonts.akayaTelivigala(
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Get.to(() => CartScreen(), transition: Transition.downToUp);
              },
              icon: Icon(Icons.shopping_cart))
        ]),
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
                padding: const EdgeInsets.only(left: 115, top: 10),
                child: Row(
                  children: [
                    BlinkText(
                      "FLASH DEALS",
                      beginColor: const Color.fromARGB(255, 0, 0, 0),
                      endColor: Colors.orange,
                      style: GoogleFonts.acme(
                        color: Color.fromARGB(255, 0, 0, 7),
                        fontStyle: FontStyle.normal,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Icon(
                        IconlyBold.discount,
                        color: const Color.fromARGB(255, 111, 24, 17),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(width: 5000, child: Discount());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 100),
                    //   child: Text(
                    //     "ALL PRODUCTS",
                    //     style: GoogleFonts.lato(
                    //       color: Color.fromARGB(255, 0, 0, 7),
                    //       fontStyle: FontStyle.normal,
                    //       fontSize: 20,
                    //       letterSpacing: 1,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 85.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            Get.to(CartScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 20,
                              shadowColor: Colors.grey,
                              minimumSize: Size(80, 35)),
                          child: Row(
                            children: [
                              BlinkText(
                                "ALL PRODUCTS",
                                beginColor: const Color.fromARGB(255, 0, 0, 0),
                                endColor: Colors.blue,
                                style: GoogleFonts.acme(
                                  color: Color.fromARGB(255, 0, 0, 7),
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        IconlyBold.bag2,
                        color: const Color.fromARGB(255, 111, 24, 17),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                childAspectRatio: 250 / 300,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(1, (index) {
                  return FeedWidget();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
