// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:project/Controllers/user_data.dart';
import 'package:project/Screens/InnerScreens/favourite_screen.dart';
import 'package:project/Screens/google_map_screen.dart';
import 'package:project/Screens/login_screen.dart';
import 'package:project/Controllers/auth_controller.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

UserData currentuserinfo = new UserData();

TextEditingController _addressTextController = new TextEditingController();
TextEditingController _nameTextController = new TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController auth = new AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Profile Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //display username
                FutureBuilder<Map<String, dynamic>>(
                  future: currentuserinfo.getCurrentUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // If the Future is still running, display a loading indicator
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If an error occurred, display an error message
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // If the Future is complete, display the user's name
                      String displayName = snapshot.data?['displayName'] ?? '';
                      String imageUrl = snapshot.data?['imageUrl'] ?? '';
                      return Column(
                        children: [
                          Center(
                            child: UserProfileAvatar(
                              avatarUrl: imageUrl,
                              onAvatarTap: () {},
                              avatarSplashColor: Colors.purple,
                              radius: 80,
                              isActivityIndicatorSmall: false,
                              avatarBorderData: AvatarBorderData(
                                borderColor: Color.fromARGB(255, 2, 2, 2),
                                borderWidth: 5.0,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 21),
                                child: Icon(
                                  IconlyBold.profile,
                                  color: Color.fromARGB(255, 7, 28, 131),
                                ),
                              ),
                              Text(
                                displayName,
                                style: TextStyle(fontSize: 24),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    await _showNameDialog();
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                Divider(
                  height: 5,
                  thickness: 4,
                ),
                ListTile(
                  title: Text(
                    'Address',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Address', style: TextStyle(fontSize: 24)),
                  leading: Icon(
                    Icons.verified_user,
                    color: Color.fromARGB(255, 197, 191, 25),
                  ),
                  trailing: Icon(Icons.back_hand),
                  onTap: () async {
                    await _showAddressDialog();
                  },
                ),
                ListTile(
                  title: Text(
                    'Orders',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.wallet,
                    color: Color.fromARGB(255, 231, 133, 42),
                  ),
                  trailing: Icon(Icons.back_hand),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Wishlist',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    IconlyBold.heart,
                    color: Color.fromARGB(255, 162, 16, 31),
                  ),
                  trailing: Icon(Icons.back_hand),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavouriteScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Viewed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.remove_red_eye,
                    color: Color.fromARGB(255, 53, 80, 212),
                  ),
                  trailing: Icon(Icons.back_hand),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Google Maps',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    IconlyBold.location,
                    color: Color.fromARGB(255, 22, 198, 39),
                  ),
                  trailing: Icon(Icons.back_hand),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen()),
                    );
                  },
                ),
                ListTile(
                  // ignore: prefer_const_constructors
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 207, 20, 20),
                  ),
                  trailing: Icon(Icons.back_hand),
                  onTap: () {
                    _showLogoutDialog();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: TextField(
              onChanged: (value) {},
              controller: _addressTextController,
              maxLines: 5,
              decoration: InputDecoration(hintText: "Enter your address"),
            ),
            actions: [TextButton(onPressed: () {}, child: Text("Update"))],
          );
        });
  }

  Future<void> _showNameDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Username"),
          content: TextField(
            onChanged: (value) {
              // Update the value of the name text field
              _nameTextController.text = value;
            },
            controller: _nameTextController,
            decoration: InputDecoration(hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Update the username in Firestore
                User? user = FirebaseAuth.instance.currentUser;
                String newDisplayName = _nameTextController.text.trim();

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .update({'displayName': newDisplayName});

                // Update the local UserData instance
                //currentuserinfo = UserData();

                // Close the dialog
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Text("Log Out"),
              ],
            ),
            content: const Text("Do you relly want to Logout?"),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Cancel",
                  )),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text("Log Out", style: TextStyle(color: Colors.red))),
            ],
          );
        });
  }
}
