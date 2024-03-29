// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Screens/InnerScreens/cart_screen.dart';
import 'package:project/Widgets/inner_screen_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.menu),
              title: Row(
                children: [
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
                        Get.to(() => CartScreen(), transition: Transition.size);
                      },
                      icon: Icon(Icons.shopping_cart))
                ],
              ),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.only(top: 40),
              childAspectRatio: 450 / 360,
              crossAxisSpacing: 20,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  focusColor: Colors.amber,
                  splashColor: Colors.green,
                  hoverColor: Colors.amber,
                  highlightColor: Colors.green,
                  child: Column(
                    children: [
                      Text(
                        "VEGITABLES",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/cabbage.gif',
                        width: 130,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Vegitables')),
                    );
                  },
                ),
                InkWell(
                  splashColor: Colors.brown,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "MEATS",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/meat.gif',
                        width: 120,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Meat')),
                    );
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  splashColor: Colors.blue,
                  child: Column(
                    children: [
                      Text(
                        "BEVERAGES",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/cocktail.gif',
                        width: 120,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Drinks')),
                    );
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  splashColor: Colors.orange,
                  child: Column(
                    children: [
                      Text(
                        "DESERTS",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/desert.gif',
                        width: 120,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Desert')),
                    );
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  splashColor: Colors.lightBlue,
                  child: Column(
                    children: [
                      Text(
                        "SNACKS",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/snacks.gif',
                        width: 120,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Snacks')),
                    );
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  splashColor: Colors.red,
                  child: Column(
                    children: [
                      Text(
                        "EDUCATIONAL",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/book.gif',
                        width: 120,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Educational ')),
                    );
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  splashColor: Colors.pink,
                  child: Column(
                    children: [
                      Text(
                        "BEAUTY",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/beauty.gif',
                        width: 120,
                        height: 120,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InnerWidget(innerproduct: 'Beauty')),
                    );
                  },
                ),
              ],
            )));
  }
}
