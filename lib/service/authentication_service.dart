import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }

  // login with username and password
  Future<void> signin(
      {String email, String password, BuildContext context}) async {
    EasyLoading.show(
      status: 'Loading',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      EasyLoading.dismiss();
    } on FirebaseAuthException {
      EasyLoading.dismiss();
      SnackBar message = SnackBar(
        content: Text('Wrong username or password'),
      );
      ScaffoldMessenger.of(context).showSnackBar(message);
    }
  }

  // Login with google account
  Future<void> signInWithGoogle({BuildContext context}) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException {
      SnackBar message = SnackBar(
        content: Text('Something wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(message);
    }
  }

  //  sign in with facebook account
  Future<void> signinwithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookcredential =
          FacebookAuthProvider.credential(result.accessToken.token);

      try {
        await _firebaseAuth.signInWithCredential(facebookcredential);
      } on FirebaseAuthException {
        SnackBar message = SnackBar(
          content: Text('Something wrong'),
        );
        ScaffoldMessenger.of(context).showSnackBar(message);
      }
    }
  }

  Future<void> signup(
      {String email, String password, BuildContext context}) async {
    EasyLoading.show(
      status: 'Loading',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password); //auto login
      EasyLoading.dismiss();
      _firebaseAuth.signOut(); //setelah buat id langsung log out
      Navigator.pop(context);
    } on FirebaseAuthException {
      EasyLoading.dismiss();
      SnackBar message = SnackBar(
        content: Text('Failed to make it'),
      );
      ScaffoldMessenger.of(context).showSnackBar(message);
    }
  }
}
