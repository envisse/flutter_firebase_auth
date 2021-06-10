import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> Signout() async {
    await _firebaseAuth.signOut();
  }

  Future<String> SignIn(
      {String email, String password, BuildContext Context}) async {
    EasyLoading.show(
      status: 'Loading',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      SnackBar message = SnackBar(
        content: Text('Wrong username or password'),
      );
      ScaffoldMessenger.of(Context).showSnackBar(message);
    }
  }

  Future<String> SignUp(
      {String email, String password, BuildContext Context}) async {
    EasyLoading.show(
      status: 'Loading',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password); //auto login
      EasyLoading.dismiss();
      _firebaseAuth.signOut(); //setelah buat id langsung log out
      Navigator.pop(Context);

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      SnackBar message = SnackBar(
        content: Text('Failed to make it'),
      );
      ScaffoldMessenger.of(Context).showSnackBar(message);
    }
  }
}
