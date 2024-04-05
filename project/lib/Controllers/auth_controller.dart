import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  Future<String> signUpUser(String mobileNumber, String displayName,
      String email, String password, String imageUrl) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          displayName.isNotEmpty &&
          mobileNumber.isNotEmpty &&
          imageUrl.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
          'displayName': displayName,
          'mobileNumber': mobileNumber,
          'email': email,
          'imageUrl': imageUrl
        });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signInUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {}
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return 'Successfully logged in';
    } catch (e) {
      return e.toString();
    }
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
      });

      return 'Successfully signed in with Google';
    } catch (e) {
      return 'Failed to sign in with Google: $e';
    }
  }

  Future passwordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
