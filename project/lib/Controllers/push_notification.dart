import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("some notification recieved");
  }
}

class PushNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    // Initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static listenForLocationChanges() async {
    Geolocator.getPositionStream().listen((Position position) {
      checkRange(position);
    });
  }

  static checkRange(Position position) {
    double distance = Geolocator.distanceBetween(
      6.078233537267376,
      80.19211614479477,
      position.latitude,
      position.longitude,
    );

    if (distance < 10) {
      sendNotification();
    }
  }

  static void sendNotification() async {
    List<String> discountData = await DiscountDataFromFirestore();

    String imageUrl = 'assets/Images/carrot.jpg';

    final String filePath = imageUrl;
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(filePath),
            largeIcon: FilePathAndroidBitmap(filePath));

    // Create AndroidNotificationDetails with the BigPictureStyleInformation
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // notification content
    String notificationContent = '';
    for (String item in discountData) {
      notificationContent += '$item\n';
    }

    // Show the notification
    await _flutterLocalNotificationsPlugin.show(
      0,
      'LuxeMart Deals of the Day',
      notificationContent, // Trim to remove trailing newline
      platformChannelSpecifics,
    );
  }

//for getting notification data
  static Future<List<String>> DiscountDataFromFirestore() async {
    List<String> dataList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    querySnapshot.docs.forEach((doc) {
      if (doc.data()['price'] != doc.data()['discountPrice'])
        dataList.add(doc.data()['title']);
    });

    return dataList;
  }
}





























// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PushNotification {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static Future intt() async {
//     await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true);

//     //for fcm token

//     final token = await _firebaseMessaging.getToken();
//     print("tokennnnnn ${token}");
//   }

// //to get notification when app is using foreground
//   static Future localNotiInit() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) => null,
//     );
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onNotificationTap,
//         onDidReceiveBackgroundNotificationResponse: onNotificationTap);
//   }
//   //ontap local notification

//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     print("dsf");
//   }
//   // static void onNotificationTap(NotificationResponse notificationResponse) {
//   //   navigatorKey.currentState!
//   //       .pushNamed("/message", arguments: notificationResponse);
//   // }

//   // show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }
// }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




