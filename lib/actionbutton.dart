import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Buttonaction {
  static Future login(
      {GlobalKey<FormState> formstate,
      TextEditingController username,
      TextEditingController password,
      BuildContext context}) async {
    if (!formstate.currentState.validate()) {
      return null;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: username.text, password: password.text);

      if (userCredential.user != null) {
        Snackbar.snackbar(context, 'Logged in');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Snackbar.snackbar(context, 'User not found');
      }
    }
  }
}

// Class for snackbar
class Snackbar {
  static void snackbar(BuildContext context, String text) {
    {
      SnackBar message = SnackBar(
        content: Text(text),
      );
      ScaffoldMessenger.of(context).showSnackBar(message);
    }
  }
}
