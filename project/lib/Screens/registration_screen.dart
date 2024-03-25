// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:project/Screens/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Controllers/auth_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? _image;
  AuthController _authController = new AuthController();
  TextEditingController? _emailController = new TextEditingController();
  TextEditingController? _passwordController = new TextEditingController();
  TextEditingController? _displayNameController = new TextEditingController();
  TextEditingController? _mobileNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/Images/carrot.jpg'),
        title: Text(
          "SIGN UP TO LUXEMART",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontStyle: FontStyle.normal),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
                controller: _displayNameController,
                decoration: InputDecoration(
                    hintText: "user name",
                    hintStyle: TextStyle(color: Colors.green))),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email address",
                  hintStyle: TextStyle(color: Colors.green)),
            ),
            TextFormField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                    hintText: "Mobile number",
                    hintStyle: TextStyle(color: Colors.green))),
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.green))),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                    minimumSize: Size(180, 40),
                    foregroundColor: const Color.fromARGB(
                        255, 12, 14, 14), // foregroundColor is now primary
                    disabledBackgroundColor:
                        Colors.white, // This sets the text color
                    side: BorderSide(
                        color: Color.fromARGB(255, 163, 201, 13), width: 5),
                    backgroundColor: Colors.white),
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _image = File(image.path);
                  }
                },
                child: Text('Select image'),
              ),
            ),
            TextButton(
                onPressed: () async {
                  await _authController.signInWithGoogle();
                  // if (mounted) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BottomBarScreen()),
                  //   );
                  // }
                },
                child: Text("Google")),
            TextButton(
              onPressed: () async {
                var imageName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                var storageRef = FirebaseStorage.instance
                    .ref()
                    .child('user_profiles/$imageName.jpg');
                var uploadTask = storageRef.putFile(_image!);
                String downloadUrl =
                    await (await uploadTask).ref.getDownloadURL();
                await _authController.signUpUser(
                    _mobileNumberController!.text,
                    _displayNameController!.text,
                    _emailController!.text,
                    _passwordController!.text,
                    downloadUrl);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
