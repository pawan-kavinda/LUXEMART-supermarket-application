// ignore_for_file: prefer_final_fields, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/Controllers/auth_controller.dart';
import 'package:project/Screens/bottom_bar_screen.dart';

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
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: "Email address"),
          ),
          TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password")),
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
            child: Text("Login"),
          )
        ],
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
}
