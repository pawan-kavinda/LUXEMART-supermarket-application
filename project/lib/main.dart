// ignore_for_file: unused_import
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:project/Controllers/push_notification.dart';
import 'package:project/Screens/InnerScreens/payment.dart';
import 'package:project/Screens/InnerScreens/product_details.dart';
import 'package:project/Screens/bottom_bar_screen.dart';
import 'package:project/Screens/google_map_screen.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/login_screen.dart';
import 'package:project/Screens/starter_page.dart';
import 'package:project/Widgets/all_products_widget.dart';
import 'package:provider/provider.dart';
import 'package:project/Providers/whish_list_provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51PIu4L007m7Jbqb5LOyzOmrRvQNhLWnOqJXX44t91NltE8RnpnRc2e7x3aWA7Ar3IpgvOQvC5SqbwaslAjZCKZIq00TbHxrMc7";

  PushNotification.init();
  PushNotification.listenForLocationChanges();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WhishListProvider(),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 6, 106, 11)),
            useMaterial3: true,
          ),
          home: BottomBarScreen()),
    );
  }
}
