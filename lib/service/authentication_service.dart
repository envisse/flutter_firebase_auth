import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> Signout()async {
    await _firebaseAuth.signOut();
  }

  Future<String> SignIn({String email, String password,BuildContext Context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      SnackBar message = SnackBar(
        content: Text('Wrong username or password'),
      );
      ScaffoldMessenger.of(Context).showSnackBar(message);
    }
  }

  Future<String> SignUp({String email, String password,BuildContext Context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(Context);

    } on FirebaseAuthException catch (e) {
      SnackBar message = SnackBar(
        content: Text('Failed to make it'),
      );
      ScaffoldMessenger.of(Context).showSnackBar(message);
    }
  }
}
