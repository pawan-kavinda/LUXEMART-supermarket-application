import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
