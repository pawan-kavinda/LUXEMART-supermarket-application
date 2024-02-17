import 'package:flutter/material.dart';
import 'package:project/Widgets/inner_screen_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
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
                              InnerWidget(innerproduct: 'vegitable')),
                    );
                  },
                ),
                InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
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
                  onTap: () {},
                ),
                InkWell(
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
                  onTap: () {},
                ),
                InkWell(
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
                  onTap: () {},
                ),
                InkWell(
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
                  onTap: () {},
                ),
                InkWell(
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
                  onTap: () {},
                ),
                InkWell(
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
                  onTap: () {},
                ),
              ],
            )));
  }
}
