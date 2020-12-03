import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class SignUpPage extends StatefulWidget {
  static const String RouteName = '/login';

  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
          margin: EdgeInsets.fromLTRB(20, 60, 20, 20),
          color: Colors.white,
          child: Column(
            children: [
              Material(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                            child: Icon(
                              Icons.android,
                            ),
                          )
                        ]),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff5c5c5c),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                            child: Text(
                              'Login into your existing account',
                              style: TextStyle(color: Color(0xff8d8d8d)),
                            ),
                          )
                        ]),
                        Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                              child: HHEditText(
                                hint: "Enter Email Id",
                                obscureText: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHEditText(
                                  hint: "Enter Password", obscureText: true),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHButton(title: "Login", type: 2),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                elevation: 8.0,
                shadowColor: Colors.black38,
                borderRadius: BorderRadius.circular(8.0),
                borderOnForeground: true,
              ),
              InkWell(
                onTap: () {
                  print('abcd');
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text('Forgot Password',
                      style: TextStyle(color: Colors.blue)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text('Do you have an account Sign up'),
              )
            ],
          )),
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}
