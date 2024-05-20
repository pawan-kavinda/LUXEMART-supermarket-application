// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

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

    if (distance < 100000000) {
      sendNotification();
    }
  }

  static void sendNotification() async {
    List<dynamic> discountData = await DiscountDataFromFirestore();

    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        contentTitle: 'LuxeMart Deals of the Day!');

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id', 'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      //styleInformation: BigTextStyleInformation(''),
      styleInformation: bigPicture,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // notification content
    String notificationContent = '';
    int discountpercentage = 0;
    discountData.forEach((item) {
      discountpercentage =
          (((item['price'] - item['discountPrice']) / item['price']) * 100)
              .toInt();
      notificationContent += '\n'
          '${item['title']}  Up to ${discountpercentage}% \n';
    });

    // Show the notification
    await _flutterLocalNotificationsPlugin.show(
      0,
      '',
      notificationContent, // Trim to remove trailing newline
      platformChannelSpecifics,
    );
  }

  static DiscountDataFromFirestore() async {
    var dataList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    querySnapshot.docs.forEach((doc) {
      if (doc.data()['price'] != doc.data()['discountPrice'])
        dataList.add(doc.data());
    });

    return dataList;
  }
}
