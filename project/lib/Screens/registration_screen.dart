// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/Controllers/auth_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AuthController _authController = new AuthController();
  TextEditingController? _emailController = new TextEditingController();
  TextEditingController? _passwordController = new TextEditingController();
  TextEditingController? _displayNameController = new TextEditingController();
  TextEditingController? _mobileNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Column(
        children: [
          TextFormField(
              controller: _displayNameController,
              decoration: InputDecoration(hintText: "user name")),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: "Email address"),
          ),
          TextFormField(
              controller: _mobileNumberController,
              decoration: InputDecoration(hintText: "Mobile number")),
          TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password")),
          TextButton(
            onPressed: () async {
              await _authController.signUpUser(
                  _mobileNumberController!.text,
                  _displayNameController!.text,
                  _emailController!.text,
                  _passwordController!.text);
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
