import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Screens/InnerScreens/product_details.dart';

class InnerWidget extends StatefulWidget {
  // const InnerWidget({super.key});
  final String innerproduct;
  InnerWidget({required this.innerproduct});

  @override
  State<InnerWidget> createState() => _InnerWidgetState();
}

class _InnerWidgetState extends State<InnerWidget> {
  final _productstream = FirebaseFirestore.instance.collection('products');
  final TextEditingController _searchTextController = TextEditingController();
  String searchtext = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 151, 177, 139),
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            widget.innerproduct,
            style: GoogleFonts.aboreto(
                fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ),
      ),
      body: StreamBuilder(
          //methana wenas karapan constructor ekata category eka pass karaddi screen eka wenas wenna
          stream: _productstream
              .where('category', isEqualTo: widget.innerproduct)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading....');
            }
            var docs = snapshot.data!.docs;

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 300 / 360),
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                      child: InkWell(
                        onTap: () {
                          Get.to(ProductDetailsScreen(
                              title: title,
                              price: price,
                              discountPrice: discountPrice,
                              imgUrl: imgUrl,
                              category: category));
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(children: [
                          Image.network(
                            imgUrl,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    title,
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                ),
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
                                  icon: Icon(IconlyBold.plus),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
