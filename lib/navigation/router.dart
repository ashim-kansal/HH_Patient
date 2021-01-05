import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/creatAccount.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/screens/FaqPage.dart';
import 'package:flutter_app/screens/aboutus.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/change_password.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/chatlist.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/drinking_diary.dart';
import 'package:flutter_app/screens/journal.dart';
import 'package:flutter_app/screens/language.dart';
import 'package:flutter_app/screens/myplan.dart';
import 'package:flutter_app/screens/privacy.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/screens/ReScheduleSession.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/screens/terms.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart' as upcoming;
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/feedback.dart';

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
      final OTPArguements args = settings.arguments;
      return MaterialPageRoute(builder: (context) => OtpPage(from: args.from));
    case ResetPasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case QuestionairePage.RouteName:
      final QuestionaireArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => QuestionairePage(programId: args.programId));
    case MyPlans.RouteName:
      final MyPlansArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => MyPlans(isUpdate: args.isUpdate?true:false,));
    case CurrentPlansPage.RouteName:
      return MaterialPageRoute(builder: (context) => CurrentPlansPage());
    case CancelPlansPage.RouteName:
      return MaterialPageRoute(builder: (context) => CancelPlansPage());
    case DrinkingDiaryPage.RouteName:
      return MaterialPageRoute(builder: (context) => DrinkingDiaryPage());
    case Dashboard.RouteName:
      return MaterialPageRoute(builder: (context) => Dashboard());
    case TherapistPage.RouteName:
      final ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => TherapistPage(title: args.title,));
    case BookSessionPage.RouteName:
      final Result args = settings.arguments;

      return MaterialPageRoute(builder: (context) => BookSessionPage(data: args,));
    case MyAssessmentPage.RouteName:
      return MaterialPageRoute(builder: (context) => MyAssessmentPage());
    case SessionPage.RouteName:
      return MaterialPageRoute(builder: (context) => SessionPage());
    case ReScheduleSessionPage.RouteName:
      final upcoming.Result args = settings.arguments;
      return MaterialPageRoute(builder: (context) => ReScheduleSessionPage(sessionId: args.id, therapistId: args.therapistId.id,
        name: args.therapistId.firstName+' '+args.therapistId.lastName,role: '', image: '',));
    case ChatListPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChatListPage());
    case VideoCallPage.RouteName:
      return MaterialPageRoute(builder: (context) => VideoCallPage(token: '',roomName: '',identity: '',));
    case JournalPage.RouteName:
      return MaterialPageRoute(builder: (context) => JournalPage());
    case CreateAccountPage.RouteName:
      return MaterialPageRoute(builder: (context) => CreateAccountPage());
    case EditProfilePage.RouteName:
      final ProfileArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => EditProfilePage(data: args.data));
    case ProfilePage.RouteName:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case ReviewPage.RouteName:
      return MaterialPageRoute(builder: (context) => ReviewPage());
    case SettingsPage.RouteName:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case LanguagePage.RouteName:
      final LanguageArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => LanguagePage(languagedata: args.language));
    case ChnagePasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChnagePasswordPage());
    case ChatPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChatPage());
    case FeedbackPage.RouteName:
      return MaterialPageRoute(builder: (context) => FeedbackPage());
    case NotificationPage.RouteName:
      return MaterialPageRoute(builder: (context) => NotificationPage());
    case TermsPage.RouteName:
      return MaterialPageRoute(builder: (context) => TermsPage());
    case PrivacyPolicy.RouteName:
      return MaterialPageRoute(builder: (context) => PrivacyPolicy());
    case FaqPage.RouteName:
      return MaterialPageRoute(builder: (context) => FaqPage());
    case AssessmentFormPage.RouteName:
      final AssessmentArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AssessmentFormPage(data: args.result));
    case AboutUs.RouteName:
      final ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AboutUs(title: args.title));
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
  }
}