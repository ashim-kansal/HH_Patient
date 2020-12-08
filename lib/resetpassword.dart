import 'package:flutter/material.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String RouteName = '/reset_password';

  ResetPasswordPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password', style: TextStyle(color: Colors.white)),
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
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Image.asset('assets/images/ic_new_password.png', height: 118,width: 75,),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                'Enter your new password below.',
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
                                    hint: "Enter New Password",
                                    obscureText: true,
                                    controller: passwordController,
                                    error: widget.error,
                                    errorText:
                                    'Please enter a new password',
                                    showeye: true
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: "Confirm Password",
                                    obscureText: true,
                                    controller: cpasswordController,
                                    error: widget.error,
                                    errorText:
                                    'Please enter a valid confirm password',
                                    showeye: true
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                                  child: HHButton(
<<<<<<< HEAD
                                    isEnable: true,
                                    title: "Reset",
=======
                                    title: "Proceed",
                                    isEnable: true,
>>>>>>> fd2e5939107816206a070aed30ac7709bb382bc4
                                    type: 2,
                                    onClick: () {
                                      Navigator.pushNamed(context, SignUpPage.RouteName);
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
