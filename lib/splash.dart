import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';

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
                  Navigator.pushNamed(context, SelectLanguage.RouteName )
                }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo()
    );
  }
}


