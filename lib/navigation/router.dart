import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Splash.RouteName:
      return MaterialPageRoute(builder: (context) => Splash());
    case SelectLanguage.RouteName:
      return MaterialPageRoute(builder: (context) => SelectLanguage());
    case LoginPage.RouteName:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case MyGoals.RouteName:
      return MaterialPageRoute(builder: (context) => MyGoals());
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
  }
}