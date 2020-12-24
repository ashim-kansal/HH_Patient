import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/screens/dashboard.dart';

class Splash extends StatefulWidget{

  static const String RouteName = '/';

  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{

  String data = "";
  String nameKey = "_key_name";

  @override
  void initState() async {
    super.initState();

   

    const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler(
      (MethodCall methodcall) async {
        if (methodcall.method == 'getAll') {
          return {"flutter." + nameKey: "[ No Name Saved ]"};
        }
        return null;
      },
    );
    

    Timer(Duration(seconds: 3),
      ()=>{
            Navigator.pop(context),
            Navigator.pushNamed(context, SelectLanguage.RouteName)
      });
  }

  void checkIfUserLoggedIn () async {

     var token = await GetStringToSP("token");

     Timer(Duration(seconds: 3),
      ()=>{
            Navigator.pop(context),
            if (token != "") {
              Navigator.pushNamed(context, Dashboard.RouteName)
            }else{
              Navigator.pushNamed(context, SelectLanguage.RouteName)
            },
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        color: Color(0xff777CEA),
        child: Center(
          child: Image.asset('assets/images/ic_appicon_white.png',
          height: 100,
          width: 150,
        ),
        )
        

    );
  }
}


