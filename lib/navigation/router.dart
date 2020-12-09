import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/creatAccount.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/journal.dart';
import 'package:flutter_app/screens/sessions.dart';
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
    case SessionPage.RouteName:
      return MaterialPageRoute(builder: (context) => SessionPage());
    case ChatListPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChatListPage());
    case JournalPage.RouteName:
      return MaterialPageRoute(builder: (context) => JournalPage());
    case CreateAccountPage.RouteName:
      return MaterialPageRoute(builder: (context) => CreateAccountPage());
    case AssessmentFormPage.RouteName:
      final ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AssessmentFormPage(title: args.title, enable: args.completed?true:false,));
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
  }
}