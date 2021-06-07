import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_firebase_auth/actionbutton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('firebase Authentication'),
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'LOGIN',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Form(
                      key: _formkey,
                      child: Container(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _username,
                              // validator if it's not email
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "empty";
                                } else if (!EmailValidator.validate(value)) {
                                  return "wrong email format";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _password,
                              validator: (value) =>
                                  value.isEmpty ? "fill password" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () => Buttonaction.login(
                                        context: context,
                                        formstate: _formkey,
                                        password: _password,
                                        username: _username),
                                    child: Text('Login')))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register page'),
      ),
      body: Center(
        child: Text('Register Page'),
      ),
    );
  }
}
