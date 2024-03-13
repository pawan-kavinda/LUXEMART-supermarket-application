// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
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
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Icon(Icons.shopping_cart)
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
                      const Text(
                        "Vegitables",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/cabbage.jpg',
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
                      const Text(
                        "Meats",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/chicken.jpg',
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
                      const Text(
                        "Drinks",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/anchor.jpg',
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
                      const Text(
                        "Deserts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/carrot.jpg',
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
                      const Text(
                        "Snacks",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/snacks.jpg',
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
                      const Text(
                        "Educational",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/educational.jpg',
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
                      const Text(
                        "Beauty Packs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/Images/beauty.jpg',
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
