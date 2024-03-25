// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget(
      {Key? key,
      required this.image,
      required this.discount_price,
      required this.price})
      : super(key: key);

  final String image;
  final String discount_price;
  final String price;

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
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
                        widget.image,
                        height: 70,
                        fit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.favorite,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                      Text(
                        "rs.90",
                        style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
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
