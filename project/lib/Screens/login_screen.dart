// ignore_for_file: prefer_final_fields, unnecessary_new, prefer_const_constructors

// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/Controllers/auth_controller.dart';
import 'package:project/Screens/bottom_bar_screen.dart';
import 'package:project/Screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController _authController = new AuthController();
  TextEditingController? _emailController = new TextEditingController();
  TextEditingController? _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/Images/carrot.jpg'),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SIGN IN TO LUXEMART",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.normal),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email address",
                  hintStyle: TextStyle(color: Colors.green)),
            ),
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.green))),
            TextButton(
              onPressed: () async {
                String res = await _authController.signInUser(
                    _emailController!.text, _passwordController!.text);
                if (res == 'Successfully logged in') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomBarScreen()),
                  );
                } else {
                  _showLoginErrorDialog();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text("Login"),
              ),
            ),
            TextButton(
                onPressed: () async {
                  await signInWithGoogle();
                  // if (mounted) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BottomBarScreen()),
                  //   );
                  // }
                },
                child: Text("Google")),
            Text('Dont have an account? Click Register button below'),
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showLoginErrorDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Text("Login Error"),
              ],
            ),
            content: const Text("Check the email and password again"),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Ok",
                  )),
            ],
          );
        });
  }

  Future<String> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return 'Google Sign In cancelled';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Extract user information
      final user = userCredential.user;
      final displayName = user?.displayName ?? '';
      final email = user?.email ?? '';
      final imageUrl = user?.photoURL ?? '';

      // Add user information to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'displayName': displayName,
        'email': email,
        'imageUrl': imageUrl,
        // Add more fields as needed
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomBarScreen()),
      );
      return 'Successfully signed in with Google';
    } catch (e) {
      return 'Failed to sign in with Google: $e';
    }
  }
}
