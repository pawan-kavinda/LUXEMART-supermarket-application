// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:project/Widgets/set_location.dart';

class PaymentScreen extends StatefulWidget {
  final int price;
  PaymentScreen({required this.price});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  void makePayment() async {
    try {
      paymentIntent = await createPaymentintent();
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              style: ThemeMode.dark,
              merchantDisplayName: "LUXEMART",
              googlePay: gpay));
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("done");
    } catch (e) {
      print("display payment failed");
    }
  }

  createPaymentintent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "${widget.price}",
        "currency": "USD"
      };
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51PIu4L007m7Jbqb5vFL4cbQiIs2KVaHVHdqjUC5YpW1zBGRuMc1cUGZi4grRz2cJf1q6TklNy0hUcYPTjfi63k6g00Y05i5kdw",
            "Content_Type": "application/x-www-form-urlencoded",
          });
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Payment Screen"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetLocation()),
                    );
                  },
                  child: Text("Set Location")),
              ElevatedButton(
                onPressed: () {
                  makePayment();
                },
                child: Text("Pay Me!"),
              ),
            ],
          ),
        ));
  }
}
