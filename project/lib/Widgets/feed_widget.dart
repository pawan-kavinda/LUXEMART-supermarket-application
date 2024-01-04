import 'package:flutter/material.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({super.key});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/Images/cabbage.jpg',
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          Text(
                            "Large",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          // Row(
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {},
                          //       child: Icon(
                          //         IconlyBold.bag,
                          //         size: 22,
                          //       ),
                          //     ),
                          //     HeartBTN(),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // PriceWidget(
                  //   isOnSale: true,
                  //   price: 5,
                  //   salePrice: 2,
                  //   textPrice: "1",
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Product title",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
