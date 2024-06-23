// ignore_for_file: prefer_final_fields, unnecessary_new, prefer_const_constructors, use_build_context_synchronously

// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
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
  TextEditingController? _forgotPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          children: [
            Lottie.network(
                'https://lottie.host/2df90989-d241-4ddf-ba31-48e7a4c7416d/4DXyizGhB0.json',
                width: 250),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  hintText: "Email address",
                  hintStyle: GoogleFonts.rasa(
                      color: Colors.green, fontSize: 20, letterSpacing: 2)),
            ),
            TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(IconlyBold.lock),
                    hintText: "Password",
                    hintStyle: GoogleFonts.rasa(
                        letterSpacing: 2, color: Colors.green, fontSize: 20))),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: GestureDetector(
                    onTap: () {
                      _forgotPasswordDialog();
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Color.fromARGB(255, 0, 1, 0),
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        ));
                      });

                  String res = await _authController.signInUser(
                      _emailController!.text, _passwordController!.text);
                  if (res == 'Successfully logged in') {
                    Get.to(() => BottomBarScreen(),
                        transition: Transition.zoom);
                    //Navigator.of(context).pop();
                  } else {
                    _showLoginErrorDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shadowColor: Colors.grey,
                    minimumSize: Size(280, 35)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 98.0),
                      child: Icon(IconlyBold.login),
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontSize: 15),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20),
              child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.blue,
                          ));
                        });
                    await signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.grey,
                      minimumSize: Size(300, 35)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 95.0),
                        child: Image.asset(
                          'assets/Images/google.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Text(
                        'Google',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 15),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RichText(
                  text: new TextSpan(
                children: [
                  new TextSpan(
                    text: 'Dont have an account? ',
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  new TextSpan(
                    text: 'Click Here ',
                    style: new TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(
                          () => RegistrationScreen(),
                        );
                      },
                  ),
                  new TextSpan(
                    text: 'To Register',
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
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

  Future<void> _forgotPasswordDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Send reset link"),
            content: TextField(
              onChanged: (value) {},
              controller: _forgotPasswordController,
              maxLines: 2,
              decoration: InputDecoration(hintText: "Enter your address"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_forgotPasswordController!.text.isNotEmpty) {
                      _authController
                          .passwordReset(_forgotPasswordController!.text);
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("Update"))
            ],
          );
        });
  }
}
