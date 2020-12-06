import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/signup.dart';
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
    case SignUpPage.RouteName:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case MyGoals.RouteName:
      return MaterialPageRoute(builder: (context) => MyGoals());
    case ForgotPasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
    case OtpPage.RouteName:
      return MaterialPageRoute(builder: (context) => OtpPage());
    case ResetPasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case MyPlans.RouteName:
      return MaterialPageRoute(builder: (context) => MyPlans());
    case Dashboard.RouteName:
      return MaterialPageRoute(builder: (context) => Dashboard());
    case TherapistPage.RouteName:
      return MaterialPageRoute(builder: (context) => TherapistPage());
    case BookSessionPage.RouteName:
      return MaterialPageRoute(builder: (context) => BookSessionPage());
    case MyAssessmentPage.RouteName:
      return MaterialPageRoute(builder: (context) => MyAssessmentPage());
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
  }
}