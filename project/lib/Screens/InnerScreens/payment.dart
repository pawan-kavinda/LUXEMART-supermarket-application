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
                      MaterialPageRoute(
                          builder: (context) =>
                              SetLocation(price: widget.price)),
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:project/Controllers/user_data.dart';
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/utils.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:location/location.dart';
// import 'dart:math';

// import 'package:project/Screens/home_screen.dart';

// class PaymentScreen extends StatefulWidget {
//   final int price;
//   PaymentScreen({required this.price});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   Location locationController = Location();
//   LatLng? _currentPosition;
//   LatLng? _deliveryLocation;
//   GoogleMapController? _googleMapController;
//   bool _isLoading = true;
//   final firestore = FirebaseFirestore.instance;
//   UserData userData = new UserData();
//   List<String> orderedProducts = [];
//   TextEditingController? _mobileNoController = new TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     getLocationData();
//     getOrderProducts();
//     // _deliveryLocation = _currentPosition;
//   }

//   @override
//   void dispose() {
//     _googleMapController?.dispose();
//     super.dispose();
//   }

//   Future<void> getLocationData() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     // Checking whether location service is on
//     _serviceEnabled = await locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     // Requesting location permission
//     _permissionGranted = await locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     LocationData locationData = await locationController.getLocation();
//     setState(() {
//       _currentPosition =
//           LatLng(locationData.latitude!, locationData.longitude!);
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Show us where to deliver",
//           style: GoogleFonts.lato(
//               fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                       color: Color.fromARGB(
//                           255, 44, 208, 19), // Set border color here
//                       width: 2, // Set border width here
//                     )),
//                     height: 400,
//                     child: GoogleMap(
//                       mapType: MapType.normal,
//                       initialCameraPosition: CameraPosition(
//                         target: _currentPosition!,
//                         zoom: 15,
//                       ),
//                       onMapCreated: (GoogleMapController controller) {
//                         _googleMapController = controller;
//                       },
//                       markers: {
//                         Marker(
//                           markerId: MarkerId('currentLocation'),
//                           position: _currentPosition!,
//                           draggable: true,
//                           onDragEnd: ((LatLng deliveryLocation) {
//                             setState(() {
//                               _currentPosition = deliveryLocation;
//                             });
//                             debugPrint(_currentPosition!.latitude.toString());
//                             debugPrint(_currentPosition!.longitude.toString());
//                           }),
//                         )
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: TextFormField(
//                     textAlign: TextAlign.justify,
//                     controller: _mobileNoController,
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.email_rounded),
//                         hintText: "Contact Number",
//                         hintStyle: GoogleFonts.rasa(
//                             color: Colors.green,
//                             fontSize: 20,
//                             letterSpacing: 2)),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     addOrderDetails();
//                   },
//                   child: Text("Set Location"),
//                 ),
//               ],
//             ),
//     );
//   }

//   void addOrderDetails() async {
//     //for loading indicator
//     if (_currentPosition != null && _mobileNoController!.text.isNotEmpty) {
//       setState(() {
//         _isLoading = true;
//       });

//       User? user = FirebaseAuth.instance.currentUser;
//       FirebaseFirestore.instance.collection('Pending Orders').add({
//         'order_ID': user!.uid + Random().nextInt(100).toString(),
//         'customer_name': user.displayName,
//         'customer_mobileNo': _mobileNoController!.text,
//         'total_price': widget.price,
//         'location': GeoPoint(
//           _currentPosition!.latitude,
//           _currentPosition!.longitude,
//         ),
//         'product_list': orderedProducts
//       });
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Order Placed"),
//               content: Text("Your order has been placed successfully!"),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("OK"),
//                 ),
//               ],
//             );
//           });
//       //display loading indicator for 2 seconds after location confirmation
//       await Future.delayed(Duration(seconds: 3));
//       setState(() {
//         _isLoading = false;
//       });

//       Get.to(() => HomeScreen(), transition: Transition.cupertino);
//     } else {
//       debugPrint("Error: _currentPosition is null");
//     }
//   }

//   void getOrderProducts() async {
//     orderedProducts = await userData.getCurrentUserCartDataOrder();
//   }
// }
