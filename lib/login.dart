import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/utils/colors.dart';
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
          margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Material(
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                child: Container(
              
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Container(decoration: BoxDecoration(
                      borderRadius: 
                      BorderRadius.only(
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
                              'Welcome back',
                              style: TextStyle(
                                  fontSize: 22,
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
                              style: TextStyle(color: Color(0xff8d8d8d), fontSize: 15),
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
                                showeye: true
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHButton(title: "Login", type: 4, isEnable: true,onClick: (){
                                Navigator.pushNamed(context, Dashboard.RouteName);
                              },),
                            ),
                          ]),
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordPage.RouteName);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text('Forgot Password?',
                      style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF)),

                ),
              ),

              SizedBox(height: 25),
  
              Container(
                child: Center(
                  child : Row(
                  children: <Widget>[
                    
                    Checkbox( 
                      checkColor: Colors.greenAccent,  
                      activeColor: Colors.red,  
                      value: false,  
                      onChanged: (bool value) {  
                       
                      },  
                    ),
                    Flexible(
                      child: Center(child: 
                        RichText(
                          text: TextSpan(
                            text: 'By continuing, you agree to our ',
                            style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Color(0xff707070)),
                            children: <TextSpan>[
                              TextSpan(text: 'Terms of Service ', style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14)),
                              TextSpan(text: '& ', style: TextStyle(color: Color(0xff707070), decoration: TextDecoration.none, fontSize: 14)),
                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14)),
                            ],
                          ),
                        )
                      ,) ),
                  ]
                ),
                ),
              ),
             

              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: HH_Colors.borderGrey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child:  RichText(
                          text: TextSpan(
                            text: 'Do you have an account ',
                            style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Color(0xff707070)),
                            children: <TextSpan>[
                              TextSpan(text: 'Sign Up', 
                                style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => {
                                    Navigator.pushNamed(context, SignUpPage.RouteName)
                                  }),
                            ],
                          ),
                        )
              )
            ],
          )),
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
