import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/creatAccount.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/StateModel.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;

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
  
  List<CountryList> listProvinces;

  String stateDropdown = 'Select Province';
  String countryDropdown = "Albania";
  String pwdValidation = "Please enter a valid password";
  bool securepwd = true;
  bool isChecked = true;
  bool countrySelected = false;
  String countryCode = "";
  void signupHandler(){

    String fname = fnameController.text;
    String lname = lnameController.text;
    String email = emailController.text;
    String location = locationController.text;
    String password = passwordController.text;
    var number = phoneController.text;
    String country = countryDropdown;
    String state = stateDropdown;

    var emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');


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
         widget.fnameError = false;
        widget.lnameError = false;
        widget.emailError = true;
        widget.pwdError = false;
        widget.numberError = false;
        widget.locationError = false;
      });
      return;
    }

    if(!pwdRegex.hasMatch(password)){
      setState(() {
        widget.fnameError = false;
        widget.lnameError = false;
        widget.emailError = false;
        widget.pwdError = true;
        widget.numberError = false;
        widget.locationError = false;
        pwdValidation = "Password should be alpha-numeric with 1 Small, Capital and Special character.as";
      });
      return;
    }

    setState(() {
      pwdValidation = "Please enter a valid password";
    });

    if(!isChecked){
      showToast("Please agree with terms & conditions");
      return;
    }

    buildShowDialog(context);
    APIService apiService = new APIService();
     apiService.registerApiHandler(fname, lname, email, location, password, number, country, state, countryCode).then((value) => {
      Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
        ()=> {
          showToast(value.responseMsg),
      }),
      //  showToast(value.responseMsg),
       if(value.responseCode == 200){
         SetStringToSP("userID", value.userID),
         SetStringToSP("token", value.token),
         Timer(Duration(seconds: 2),
            ()=>{
                  Navigator.pop(context),
                  // arguments: OTPArguements("forgot")
                  // Navigator.pushNamed(context, MyPlans.RouteName, arguments: MyPlansArguments(false)),
                  Navigator.pushNamed(context, OtpPage.RouteName, arguments: OTPArguements("signup")),
            }
          ),
       }
     });
    // Navigator.pushNamed(context, MyPlans.RouteName, arguments: MyPlansArguments(false));
  }

  // show circular 
  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child:CircularProgressIndicator(),
        );
    });
  }

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
         Container(
            margin: EdgeInsets.fromLTRB(20, 60, 20, 40),
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
                              "Lets get started!",
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
                                errorText: pwdValidation,
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
                              margin: EdgeInsets.only(top: 0, bottom: 10, left: 15, right: 15),
                              padding: const EdgeInsets.only(left: 20.0,right: 10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border : Border.all(color: HH_Colors.borderGrey, width: 1.2),
                                borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child:DropdownButtonHideUnderline (
                                child: new FutureBuilder<CountryList>(
                                  future: getAllCountry(),
                                  builder: (context, snapshot) {
                                   if (snapshot.connectionState == ConnectionState.done) {
                                      if(snapshot.hasError){
                                        return new DropdownButton<String>(
                                          value: "No Data Found",
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Color(0xffC5C4C4),
                                          iconSize: 38,
                                          elevation: 16,
                                          style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                        );
                                      }
                                      return new DropdownButton<String>(
                                        isExpanded: true,
                                        value: countryDropdown,
                                        // decoration: new InputDecoration(icon: Icon(Icons.language)), 
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconEnabledColor: Color(0xffC5C4C4),
                                        iconSize: 38,
                                        elevation: 16,
                                        style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                        items: snapshot.data.result.map((fc) => 
                                              DropdownMenuItem<String>(
                                                child: Text(fc.name),
                                                value: fc.name
                                              )
                                        ).toList(),
                                        onChanged: (String newValue){
                                          getAllStates(newValue);
                                          var obj = snapshot.data.result.firstWhere((obj) => obj.name == newValue);
                                          print(obj.phoneCode);
                                          setState(() {
                                            countryDropdown = newValue;
                                            countryCode = obj.phoneCode;
                                            stateDropdown= "Select Province";
                                          });
                                        },
                                      );
                                   }else
                                    return Container(
                                      child: Center(child: CircularProgressIndicator(),),
                                    );
                                  },)
                              )
                            ),
                            
                          
                            Container(
                              margin: EdgeInsets.only(bottom: 20, left: 15,right: 15),
                              padding: const EdgeInsets.only(left: 20.0,right: 10.0,),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: HH_Colors.borderGrey, width: 1.2),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: DropdownButtonHideUnderline(
                                child: 
                                // countrySelected ? (
                                  new FutureBuilder<StateList>(
                                  future: getAllStates(countryDropdown),
                                  builder: (context, snapshot) {
                                   if (snapshot.connectionState == ConnectionState.done) {
                                      if(snapshot.hasError){
                                        return new DropdownButton<String>(
                                          value: "No Data Found",
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Color(0xffC5C4C4),
                                          iconSize: 38,
                                          elevation: 16,
                                          style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                        );
                                      }
                                      // if(stateDropdown == "Select Province"){
                                        snapshot.data.result[0].states.add("Select Province");
                                      // }
                                      // else {
                                          // stateDropdown = snapshot.data.result[0].states.length == 0 ? "No Record Found": stateDropdown
                                      // }
                                      
                                      // var stateList = snapshot.data.result.firstWhere((element) => element.country == countryDropdown);
                                      return new DropdownButton<String>(
                                        isExpanded: true,
                                        value: stateDropdown,
                                        // decoration: new InputDecoration(icon: Icon(Icons.language)), 
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconEnabledColor: Color(0xffC5C4C4),
                                        iconSize: 38,
                                        elevation: 16,
                                        style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                        items: snapshot.data.result[0].states.map((fc) => 
                                              DropdownMenuItem<String>(
                                                child: Text(fc),
                                                value: fc
                                              )
                                        ).toList(),
                                        onChanged: (String stateval) async {
                                          setState(() {
                                            stateDropdown = stateval;
                                          });
                                        },
                                      );
                                   }else
                                    return Container(
                                      child: Center(child: CircularProgressIndicator(),),
                                    );
                                  },)
                              )

                            ),


                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 20, 5, 10),
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

            Container(

                margin: EdgeInsets.only(top: 10, right: 40, left: 40, bottom: 20),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                    // shape: BoxShape.rectangle,
                    border: Border.all(color: HH_Colors.borderGrey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Back to ',
                      style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Color(0xff707070), fontFamily: "ProximaNova"),
                      children: <TextSpan>[
                        TextSpan(text: 'Login', 
                          style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14, fontFamily: "ProximaNova"),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                              // checkToken()
                              Navigator.pushNamed(context, LoginPage.RouteName)
                            }),
                      ],
                    ),
                  )
                )
              )
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
