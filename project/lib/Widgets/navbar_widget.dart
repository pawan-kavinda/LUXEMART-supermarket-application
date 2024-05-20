// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Screens/InnerScreens/favourite_screen.dart';
import 'package:project/Screens/category_screen.dart';
import 'package:project/Screens/google_map_screen.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/login_screen.dart';
import 'package:project/Screens/profile_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 280,
        surfaceTintColor: Color.fromARGB(255, 0, 2, 0),
        backgroundColor: Color.fromARGB(255, 58, 57, 57),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'LUXE MART',
                style: TextStyle(
                    color: Color.fromARGB(255, 147, 147, 146), fontSize: 41),
              ),
              // decoration: BoxDecoration(
              //     color: Colors.green,
              //     image: DecorationImage(
              //         fit: BoxFit.fitWidth,
              //         image: AssetImage('assets/Images/four.jpg'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListTile(
                leading: Icon(
                  IconlyBold.heart,
                  color: Color.fromARGB(255, 0, 0, 0),
                  weight: 200,
                ),
                focusColor: const Color.fromARGB(255, 255, 255, 255),
                title: Text(
                  'Wish List',
                  style: GoogleFonts.acme(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => {Get.to(() => FavouriteScreen())},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListTile(
                leading: Icon(
                  IconlyBold.user2,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text(
                  'Profile',
                  style: GoogleFonts.acme(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => {Get.to(() => ProfileScreen())},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListTile(
                leading: Icon(
                  IconlyBold.category,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text(
                  'Categories',
                  style: GoogleFonts.acme(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => {Get.to(() => CategoryScreen())},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListTile(
                leading: Icon(
                  IconlyBold.location,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text(
                  'Locations',
                  style: GoogleFonts.acme(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => {Get.to(() => MapScreen())},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListTile(
                leading: Icon(
                  IconlyBold.logout,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.acme(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => {Get.to(() => LoginScreen())},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
