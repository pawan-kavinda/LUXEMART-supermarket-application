// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_background/animated_background.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:project/Screens/InnerScreens/cart_screen.dart';
import 'package:project/Screens/category_screen.dart';
import 'package:project/Widgets/all_products_widget.dart';
import 'package:project/Widgets/discount.dart';
import 'package:project/Widgets/feed_widget.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:project/Widgets/navbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
      drawer: NavDrawer(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.to(() => NavDrawer(), transition: Transition.downToUp);
        //   },
        //   icon: Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child: Icon(
        //       Icons.menu,
        //       color: Colors.black,
        //       weight: double.minPositive,
        //     ),
        //   ),
        // ),

        title: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: GoogleFonts.lato(
                      letterSpacing: 2,
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Get.to(() => CartScreen(), transition: Transition.leftToRight);
              },
              icon: Icon(Icons.shopping_cart))
        ]),
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
          baseColor: Color.fromARGB(255, 29, 193, 43),
          spawnOpacity: 0.3,
          opacityChangeRate: 0.25,
          minOpacity: 0.1,
          maxOpacity: 0.4,
          spawnMinSpeed: 30.0,
          spawnMaxSpeed: 70.0,
          spawnMinRadius: 5.0,
          spawnMaxRadius: 10.0,
          particleCount: 30,
        )),
        vsync: this,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: Swiper(
                      layout: SwiperLayout.STACK,
                      itemWidth: 370,
                      itemHeight: 250,
                      loop: true,
                      duration: 1200,
                      itemCount: _Images.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) =>
                          ClipRRect(
                              child: Image.asset(
                            _Images[index],
                            fit: BoxFit.fill,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 115, top: 10),
                  child: Row(
                    children: [
                      BlinkText(
                        "FLASH DEALS",
                        beginColor: Color.fromARGB(255, 0, 19, 1),
                        endColor: Color.fromARGB(255, 194, 0, 0),
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
                          color: Color.fromARGB(255, 4, 115, 26),
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height: 200,
                //     width: 380,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //           color: Colors.black,
                //           width: 2,
                //           strokeAlign: BorderSide.strokeAlignCenter),
                //       // color: const Color(0xff7c94b6),
                //       image: const DecorationImage(
                //         image: AssetImage('assets/Images/promo.jpg'),
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 140, left: 180),
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           Get.to(CartScreen());
                //         },
                //         style: ElevatedButton.styleFrom(
                //           primary: Colors
                //               .transparent, // Background color set to transparent
                //           elevation: 0, // No shadow
                //         ),
                //         child: Row(
                //           children: [
                //             BlinkText(
                //               "SHOP NOW",
                //               beginColor: Color.fromARGB(255, 0, 0, 0),
                //               endColor: Color.fromARGB(255, 238, 23, 23),
                //               style: GoogleFonts.acme(
                //                 color: Color.fromARGB(255, 0, 0, 7),
                //                 fontStyle: FontStyle.normal,
                //                 letterSpacing: 2,
                //                 fontSize: 25,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                        padding: const EdgeInsets.only(left: 115, top: 10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(AllProductsWidget());
                              },
                              child: Text(
                                "ALL PRODUCTS",
                                style: GoogleFonts.acme(
                                  color: Color.fromARGB(255, 0, 0, 7),
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(
                                IconlyBold.bag2,
                                color: Color.fromARGB(255, 4, 115, 26),
                              ),
                            )
                          ],
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
      ),
    );
  }
}
