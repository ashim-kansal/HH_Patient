import 'package:flutter/material.dart';
import 'package:flutter_app/creatAccount.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class SignUpPage extends StatefulWidget {
  static const String RouteName = '/signup';

  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;
   var error = false;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              child: ClipPath(

              clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),

              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 0, 10, 20),
                child: Container(
                  color: Colors.white,
                  // child: Form(
                  //   key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
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
                        
                        Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                              child: HHEditText(
                                hint: "First Name",
                                obscureText: false,
                                controller: emailController,
                                error: widget.error,
                                errorText: 'Please enter a your first name',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Last Name",
                                obscureText: false,
                                controller: emailController,
                                error: widget.error,
                                errorText: 'Please enter a your last name',
                              ),
                            ),
                             Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Email Address",
                                obscureText: false,
                                controller: emailController,
                                error: widget.error,
                                errorText: 'Please enter a valid email address',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Create Password",
                                obscureText: true,
                                controller: passwordController,
                                error: widget.error,
                                errorText: 'Please enter a valid password',
                                showeye: true
                              ),
                            ),
                             Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHEditText(
                                hint: "Enter Your Location",
                                obscureText: false,
                                controller: emailController,
                                error: widget.error,
                                errorText: 'Please enter a enter your location',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 5, 10),
                              child: HHButton(title: "Sign Up", type: 4, isEnable: true,onClick: (){
                                Navigator.pushNamed(context, CreateAccountPage.RouteName);
                              },),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                // ),
              ),
              ),
              elevation: 8.0,
              shadowColor: Colors.black38,
              borderRadius: BorderRadius.circular(15.0),
              borderOnForeground: true,
            ),
          ),
          Container(
             margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
