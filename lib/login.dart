import 'package:flutter/material.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';

class LoginPage extends StatefulWidget {
  static const String RouteName = '/login';

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
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
                  child: Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                            child: Image.asset('assets/images/ic_appicon_blue.png', height: 62, width: 104,),

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
                                controller: emailController,
                                error: widget.error,
                                errorText: 'Please enter a valid email address',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHEditText(
                                  hint: "Enter Password",
                                obscureText: true,
                                controller: passwordController,
                                error: widget.error,
                                errorText: 'Please enter a valid password',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHButton(title: "Login", type: 2, isEnable: true,onClick: (){
                                Navigator.pushNamed(context, Dashboard.RouteName);
                              },),
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
                  Navigator.pushNamed(context, ForgotPasswordPage.RouteName);
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


}
