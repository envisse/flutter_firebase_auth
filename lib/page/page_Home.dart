import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/service/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final field1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: field1,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page2(
                            text1: field1.text,
                          ),
                        ));
                  },
                  child: Text('Go to second page')),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signout();
                  },
                  child: Text('SignOut'))
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final String text1;
  Page2({this.text1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text1),
      ),
    );
  }
}
