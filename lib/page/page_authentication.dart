import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/page/page_Home.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_firebase_auth/service/authentication_service.dart';

class Authenticationchecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }
    return LoginPage();
  }
}

class LoginPage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 50,
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
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  context.read<AuthenticationService>().SignIn(
                                      email: _username.text,
                                      password: _password.text,
                                      Context: context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("can't proceed")));
                                }
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text('Sign up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                'REGISTER',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
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
                            labelText: 'Email', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _repassword,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "empty";
                          } else if (_password.text != _repassword.text) {
                            return "not match";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Re-password',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              context.read<AuthenticationService>().SignUp(
                                  email: _email.text,
                                  password: _password.text,
                                  Context: context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("can't proceed")));
                            }
                          },
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
