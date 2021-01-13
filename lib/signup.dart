import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/StateModel.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/app_localization.dart';

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


  void signupHandler(BuildContext context) async {

    String fname = fnameController.text;
    String lname = lnameController.text;
    String email = emailController.text;
    // String location = locationController.text;
    String password = passwordController.text;
    var number = phoneController.text;
    String country = countryDropdown;
    String state = stateDropdown;

    var emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');


    if(fname.trim().length == 0 && lname.trim().length == 0 && email.trim().length == 0){
      
      setState(() {
        widget.fnameError = true;
        widget.lnameError = true;
        widget.emailError = true;
        widget.pwdError = true;
        widget.numberError = true;
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
        pwdValidation = AppLocalizations.of(context).pass_validation_msg;
      });
      return;
    }

    setState(() {
      pwdValidation = AppLocalizations.of(context).valid_pwd;
    });

    if(!isChecked){
      showToast(AppLocalizations.of(context).acceptTerms);
      return;
    }

    buildShowDialog(context);
    APIService apiService = new APIService();
     apiService.registerApiHandler(fname, lname, email, password, number, country, state, countryCode).then((value) => {
      Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
        ()=> {
          showToast(value.responseMsg),
      }),
      //  showToast(value.responseMsg),
      // ignore: sdk_version_ui_as_code
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
                              AppLocalizations.of(context).lets_started,
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
                              AppLocalizations.of(context).signupTitle,
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
                                hint: AppLocalizations.of(context).fname,
                                obscureText: false,
                                controller: fnameController,
                                error: widget.fnameError,
                                errorText: AppLocalizations.of(context).enterFirstName,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: AppLocalizations.of(context).lname,
                                obscureText: false,
                                controller: lnameController,
                                error: widget.lnameError,
                                maxLength: 16,
                                errorText: AppLocalizations.of(context).enterLastName,
                              ),
                            ),
                             Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: AppLocalizations.of(context).email,
                                obscureText: false,
                                controller: emailController,
                                error: widget.emailError,
                                maxLength: 32,
                                inputType: TextInputType.emailAddress,
                                errorText: AppLocalizations.of(context).enter_valid_email,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: HHEditText(
                                hint: AppLocalizations.of(context).createPwd,
                                obscureText: securepwd,
                                controller: passwordController,
                                error: widget.pwdError,
                                errorText: pwdValidation,
                                maxLength: 16,
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
                                hint: AppLocalizations.of(context).phone_number,
                                obscureText: false,
                                controller: phoneController,
                                error: widget.numberError,
                                maxLength: 12,
                                inputType: TextInputType.number,
                                errorText:
                                AppLocalizations.of(context).enterPhone,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                            //   child: HHEditText(
                            //     hint: "Enter Your Location",
                            //     obscureText: false,
                            //     controller: locationController,
                            //     error: widget.locationError,
                            //     errorText: 'Please enter your location',
                            //   ),
                            // ),

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
                                          value: AppLocalizations.of(context).not_data_found,
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
                                            stateDropdown= AppLocalizations.of(context).selectProvince;
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
                                          value: AppLocalizations.of(context).not_data_found,
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Color(0xffC5C4C4),
                                          iconSize: 38,
                                          elevation: 16,
                                          style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                        );
                                      }
                                      // if(stateDropdown == AppLocalizations.of(context).selectProvince){
                                        snapshot.data.result[0].states.add(AppLocalizations.of(context).selectProvince);
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
                              child: HHButton(title: AppLocalizations.of(context).signup, type: 4, isEnable: true,onClick: (){
                                signupHandler(context);
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
                          text: AppLocalizations.of(context).agree_desc,
                          style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Color(0xff707070)),
                          children: <TextSpan>[
                            TextSpan(text: AppLocalizations.of(context).terms_service, style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14)),
                            TextSpan(text: '& ', style: TextStyle(color: Color(0xff707070), decoration: TextDecoration.none, fontSize: 14)),
                            TextSpan(text: AppLocalizations.of(context).privacy, style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14)),
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
                        TextSpan(text: AppLocalizations.of(context).login,
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
