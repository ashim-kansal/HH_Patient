import 'package:flutter/material.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String RouteName = '/forgot_password';

  ForgotPasswordPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password', style: TextStyle(color: Colors.white)),
          centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Material(
                    child: ClipPath(
                      // color: Colors.white,
                      // padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),

                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0,20,20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Image.asset('assets/images/ic_lock.png', height: 118,width: 75,),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Text(
                                'Please enter you registered email address. We will help you retrieve your password.',
                                style: TextStyle(color: Color(0xff8d8d8d)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
                                  child: HHEditText(
                                    hint: "Enter Email Id",
                                    obscureText: false,
                                    controller: emailController,
                                    error: widget.error,
                                    errorText:
                                        'Please enter a valid email address',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                                  child: HHButton(
                                    title: "Proceed",
                                    type: 2,
                                      isEnable: true,
                                    onClick: () {
                                      Navigator.pushNamed(context, OtpPage.RouteName);
                                    },
                                  ),
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
                ],
              )),
          // backgroundColor: Colors.white,
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
