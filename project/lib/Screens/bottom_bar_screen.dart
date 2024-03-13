// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:project/Screens/add_products_screen.dart';
import 'package:project/Screens/google_map_screen.dart';
import 'package:project/Screens/profile_screen.dart';
import 'package:project/Screens/user_screen.dart';
import 'package:project/Screens/category_screen.dart';
import 'package:project/Screens/home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  bool _isSelected0 = true;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  final List _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
    //const MapScreen()

    //const MapScreen()
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _isSelected0 = true;
        _isSelected1 = false;
        _isSelected2 = false;
      } else if (_selectedIndex == 1) {
        _isSelected1 = true;
        _isSelected0 = false;
        _isSelected2 = false;
      } else {
        _isSelected1 = false;
        _isSelected0 = false;
        _isSelected2 = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _isSelected0
                  ? Icon(
                      IconlyBold.home,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  : Icon(
                      IconlyLight.home,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: _isSelected1
                  ? Icon(
                      IconlyBold.category,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  : Icon(
                      IconlyLight.category,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              label: "Category"),
          BottomNavigationBarItem(
              icon: _isSelected2
                  ? Icon(
                      IconlyBold.profile,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  : Icon(
                      IconlyLight.profile,
                      color: Color.fromARGB(255, 3, 3, 3),
                    ),
              label: "Profile"),
          // BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Map"),
        ],
        backgroundColor: Color.fromRGBO(220, 218, 218, 1),
      ),
    );
  }
}
