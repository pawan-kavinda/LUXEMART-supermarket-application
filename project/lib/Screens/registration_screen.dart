// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      resizeToAvoidBottomInset: false,
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
            Lottie.network(
                'https://lottie.host/089dd67c-dc4a-495b-996f-5f0d82ac5a1d/VoDqDuKyJo.json',
                width: 200),
            TextFormField(
                controller: _displayNameController,
                decoration: InputDecoration(
                    hintText: "User Name",
                    prefixIcon: Icon(IconlyBold.user2),
                    hintStyle: GoogleFonts.rasa(
                        letterSpacing: 1.5,
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email address",
                  prefixIcon: Icon(Icons.email_sharp),
                  hintStyle: GoogleFonts.rasa(
                      letterSpacing: 1.5,
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            TextFormField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                    hintText: "Mobile number",
                    prefixIcon: Icon(IconlyBold.call),
                    hintStyle: GoogleFonts.rasa(
                        letterSpacing: 1.5,
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
            TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(IconlyBold.password),
                    hintStyle: GoogleFonts.rasa(
                        letterSpacing: 1.5,
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
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
            // TextButton(
            //     onPressed: () async {
            //       await _authController.signInWithGoogle();
            //       // if (mounted) {
            //       //   Navigator.push(
            //       //     context,
            //       //     MaterialPageRoute(
            //       //         builder: (context) => BottomBarScreen()),
            //       //   );
            //       // }
            //     },
            //     child: Text("Google")),
            // TextButton(
            //     onPressed: () async {
            //       Get.to(() => LoginScreen(),
            //           transition: Transition.leftToRight);
            //     },
            //     child: Text("LoginPage")),
            // TextButton(
            //   onPressed: () async {
            //     var imageName =
            //         DateTime.now().millisecondsSinceEpoch.toString();
            //     var storageRef = FirebaseStorage.instance
            //         .ref()
            //         .child('user_profiles/$imageName.jpg');
            //     var uploadTask = storageRef.putFile(_image!);
            //     String downloadUrl =
            //         await (await uploadTask).ref.getDownloadURL();
            //     await _authController.signUpUser(
            //         _mobileNumberController!.text,
            //         _displayNameController!.text,
            //         _emailController!.text,
            //         _passwordController!.text,
            //         downloadUrl);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginScreen()),
            //     );
            //   },
            //   child: Text("Submit"),
            // ),
            ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Color.fromARGB(255, 0, 7, 1),
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 243, 243, 244)),
                        ));
                      });
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
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shadowColor: Colors.grey,
                    minimumSize: Size(280, 35)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 83.0),
                      child: Icon(IconlyBold.login),
                    ),
                    Text(
                      'Register',
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
                    await _authController.signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.grey,
                      minimumSize: Size(300, 35)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 88.0),
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
          ],
        ),
      ),
    );
  }
}
