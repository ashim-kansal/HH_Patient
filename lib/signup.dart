import 'package:flutter/material.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class SignUpPage extends StatefulWidget {
  static const String RouteName = '/signup';

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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
         Container(
            margin: EdgeInsets.fromLTRB(20, 60, 20, 20),
            color: Colors.white,
            child: Material(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  color: Colors.white,
                  // padding: EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                            child: Image.asset(
                              'assets/images/ic_appicon_blue.png',
                              height: 62,
                              width: 104,
                            ),
                          )
                        ]),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              'Lets get started!',
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
                              'Sign up for an account to unlock all features.',
                              style: TextStyle(color: Color(0xff8d8d8d)),
                            ),
                          )
                        ]),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: HHEditText(
                            hint: "First Name",
                            obscureText: false,
                            error: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: HHEditText(
                            hint: "Last Name",
                            error: false,
                            obscureText: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: HHEditText(
                            hint: "Email Address",
                            error: false,
                            obscureText: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: HHEditText(
                              error: false,
                              hint: "Create Password", obscureText: true),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: HHEditText(
                            error: false,
                            hint: "Enter Your Location",
                            obscureText: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: HHButton(title: "Sign Up", type: 2, isEnable: true,onClick: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MyPlans.RouteName, arguments: MyPlansArguments(false));
                          },),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              elevation: 8.0,
              shadowColor: Colors.black38,
              borderRadius: BorderRadius.circular(8.0),
              borderOnForeground: true,
            ),
          ),

        ],
      ),
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
