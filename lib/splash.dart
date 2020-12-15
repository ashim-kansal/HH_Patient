import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/screens/change_password.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/feedback.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/screens/settings.dart';

class Splash extends StatefulWidget{

  static const String RouteName = '/';

  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>{
                  Navigator.pop(context),
                  Navigator.pushNamed(context, Dashboard.RouteName)
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


