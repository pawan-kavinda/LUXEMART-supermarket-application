import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:project/Controllers/push_notification.dart';
import 'package:project/Screens/InnerScreens/product_details.dart';
import 'package:project/Screens/bottom_bar_screen.dart';
import 'package:project/Screens/login_screen.dart';
import 'package:project/Screens/starter_page.dart';
import 'package:provider/provider.dart';
import 'package:project/Providers/whish_list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
                seedColor: Color.fromARGB(255, 29, 231, 39)),
            useMaterial3: true,
          ),
          home: BottomBarScreen()),
    );
  }
}
