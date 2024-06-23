// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
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
      paymentIntent = await createPaymentIntent();
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
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SetLocation(price: widget.price)),
                              );
                            },
                            child: Text("Click here to continue")),
                      )
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent() async {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Few more steps to go!",
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 20),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.network(
                  'https://lottie.host/12a7ba84-5e76-46a5-8bd9-edf08286baae/I771dLUPja.json',
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04, vertical: 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 44, 208, 19),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                        vertical: screenWidth * 0.01),
                    child: Text(
                      "Before proceeding with the online card payment, ensure that you are connected to a secure and trusted network to safeguard your payment information. Assured that we do not store any of your card details on our servers.",
                      style: GoogleFonts.actor(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontSize: screenWidth * 0.04),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: AnimatedButton.strip(
                      onPress: makePayment,
                      width: screenWidth * 0.43,
                      height: screenHeight * 0.06,
                      text: 'Stripe Payment Method',
                      isReverse: true,
                      selectedTextColor: Color.fromARGB(255, 6, 0, 0),
                      stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
                      selectedBackgroundColor:
                          Color.fromARGB(255, 207, 210, 207),
                      backgroundColor: Color.fromARGB(255, 34, 68, 238),
                      textStyle: GoogleFonts.balooBhai2(
                          fontSize: screenWidth * 0.032,
                          letterSpacing: 5,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.005),
                    child: AnimatedButton.strip(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SetLocation(price: widget.price),
                          ),
                        );
                      },
                      width: screenWidth * 0.43,
                      height: screenHeight * 0.06,
                      text: 'After Delivery',
                      isReverse: true,
                      selectedTextColor: Color.fromARGB(255, 6, 0, 0),
                      stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
                      selectedBackgroundColor:
                          Color.fromARGB(255, 207, 210, 207),
                      backgroundColor: Color.fromARGB(255, 9, 186, 18),
                      textStyle: GoogleFonts.balooBhai2(
                          fontSize: screenWidth * 0.032,
                          letterSpacing: 5,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
