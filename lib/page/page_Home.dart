import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/service/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home Page'),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().Signout();
                  },
                  child: Text('SignOut'))
            ],
          ),
        ),
      ),
    );
  }
}