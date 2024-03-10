import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.amber,
        title: Text(widget.innerproduct),
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Column(children: [
                          Image.network(
                            imgUrl,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(
                                    title,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                // GestureDetector(
                                //     onTap: () {
                                //       favouriteItems.returntitle(title);
                                //       favouriteItems.returnPrice(discountprice);
                                //       favouriteItems.returnImg(imgUrl);
                                //     },
                                //     child: Icon(
                                //       IconlyLight.heart,
                                //       size: 22,
                                //     ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // PriceWidget(
                                //   isOnSale: true,
                                //   price: price,
                                //   salePrice: discountprice,
                                //   textPrice: _quantityTextController.text,
                                // ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                          //Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                // cartItems.returntitle(title);
                                // cartItems.returnPrice(discountprice);
                                // cartItems.returnImg(imgUrl);
                              },
                              child: Text(
                                "Add to cart",
                                maxLines: 1,
                                style: TextStyle(fontSize: 15),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).cardColor),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12.0),
                                              bottomRight:
                                                  Radius.circular(12.0))))),
                            ),
                          )
                        ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
