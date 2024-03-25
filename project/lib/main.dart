// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:project/Controllers/push_notification.dart';
// import 'package:project/Screens/add_products_screen.dart';
// import 'package:project/Screens/bottom_bar_screen.dart';
// import 'package:project/Screens/google_map_screen.dart';
// import 'package:project/Screens/home_screen.dart';
// import 'package:project/Screens/login_screen.dart';
// import 'package:project/Screens/registration_screen.dart';
// import 'package:project/Screens/starter_page.dart';

// Future _firebaseBackgroundMessage(RemoteMessage message) async {
//   if (message.notification != null) {
//     print("some notification recieved");
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   PushNotification.intt();
//   //listen to background notification
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

//   //handle foreground notification
//   PushNotification.localNotiInit();
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     String payloadData = jsonEncode(message.data);
//     //print("got a message in foreground");
//     // if (message.notification != null) {
//     //   PushNotification.showSimpleNotification(
//     //       title: "Don't miss out",
//     //       body: "Awsome deals upto 70% off",
//     //       payload: payloadData);
//     // }
//   });
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme:
//             ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 29, 231, 39)),
//         useMaterial3: true,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project/Controllers/push_notification.dart';
import 'package:project/Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotification.init(); // Initialize push notifications

  // Listen to location changes and send notifications based on range
  PushNotification.listenForLocationChanges();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 29, 231, 39)),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
