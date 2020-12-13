import 'package:flutter/material.dart';
import 'package:flutter_app/creatAccount.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class SignUpPage extends StatefulWidget {
  static const String RouteName = '/signup';

  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;
   var fnameError = false;
   var lnameError = false;
   var emailError = false;
   var pwdError = false;
   var numberError = false;
   var locationError = false;
   var stateError = false;
   var countryError = false;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String stateDropdown = 'Select State';
  String countryDropdown = 'Select Country';
  bool securepwd = true;
  bool isChecked = true;
  void signupHandler(){

    String fname = fnameController.text;
    String lname = lnameController.text;
    String email = emailController.text;
    String location = locationController.text;
    String password = passwordController.text;
    var number = phoneController.text;

    var emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


    if(fname.trim().length == 0 && lname.trim().length == 0 && email.trim().length == 0 && 
    location.trim().length == 0 && password.trim().length == 0 && number.trim().length == 0){
      
      setState(() {
        widget.fnameError = true;
        widget.lnameError = true;
        widget.emailError = true;
        widget.pwdError = true;
        widget.numberError = true;
        widget.locationError = true;
      });
      
      return;
    }

    if(!emailRegex.hasMatch(email)){
      setState(() {
        widget.emailError = true;
      });
      return;
    }

    if(!pwdRegex.hasMatch(password)){
      setState(() {
        widget.pwdError = true;
      });
      return;
    }

    Navigator.pushNamed(context, LoginPage.RouteName);
  }

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
                                controller: fnameController,
                                error: widget.fnameError,
                                errorText: 'Please enter your first name',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Last Name",
                                obscureText: false,
                                controller: lnameController,
                                error: widget.lnameError,
                                errorText: 'Please enter your last name',
                              ),
                            ),
                             Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Email Address",
                                obscureText: false,
                                controller: emailController,
                                error: widget.emailError,
                                errorText: 'Please enter a valid email address',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Create Password",
                                obscureText: securepwd,
                                controller: passwordController,
                                error: widget.pwdError,
                                errorText: 'Please enter a valid password',
                                showeye: true,
                                onClickEye: () {
                                  print("clickable");
                                  setState(() {
                                    securepwd = !securepwd;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Phone Number",
                                obscureText: false,
                                controller: phoneController,
                                error: widget.numberError,
                                errorText:
                                'Please enter a phone number',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: "Enter Your Location",
                                obscureText: false,
                                controller: locationController,
                                error: widget.locationError,
                                errorText: 'Please enter your location',
                              ),
                            ),

                            Container(
                              width: 295,
                              // margin: EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.only(left: 20.0,right: 10.0,),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: HH_Colors.borderGrey, width: 1.2),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: DropdownButtonHideUnderline(
                                child: new DropdownButton<String>(
                                value: stateDropdown,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconEnabledColor: Color(0xffC5C4C4),
                                iconSize: 38,
                                elevation: 16,
                                style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                items: <String>['Select State', 'Chandigarh', 'Haryana', 'Punjab'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    stateDropdown = newValue;
                                  });
                                },
                              )) 
                            
                            ),
                          Container(
                            width: 295,
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            padding: const EdgeInsets.only(left: 20.0,right: 10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border : Border.all(color: HH_Colors.borderGrey, width: 1.2),
                              borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: DropdownButtonHideUnderline (
                              child: new DropdownButton<String>(
                                isExpanded: true,
                                value: countryDropdown,
                                icon: Icon(Icons.arrow_drop_down),
                                iconEnabledColor: Color(0xffC5C4C4),
                                iconSize: 38,
                                elevation: 16,
                                style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                items: <String>['Select Country', 'India', 'Canada', 'USA'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    countryDropdown = newValue;
                                  });
                                },
                              ),
                              )
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 5, 10),
                              child: HHButton(title: "Sign Up", type: 4, isEnable: true,onClick: (){
                                signupHandler();
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
                    checkColor: Colors.white,  
                    activeColor: HH_Colors.purpleColor,  
                    value: isChecked,  
                    onChanged: (bool value) {  
                      setState(() {
                        isChecked = !isChecked;
                      });
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
