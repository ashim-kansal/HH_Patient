import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/services/navigation_service.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/navigation/router.dart' as router;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'widgets/mywidgets.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatefulWidget {
  static BuildContext myContext;

  @override
  State<StatefulWidget> createState() => _MyAppState();

}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void initState(){
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}



class _MyAppState extends State<MyApp> {  // This widget is the root of your application.
  AppLocalizationDelegate _localeOverrideDelegate = AppLocalizationDelegate(Locale('en', ''));
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    MyApp.myContext = context;
    return MaterialApp(
        title: 'HH Patient',
        onGenerateRoute: router.generateRoute,
        initialRoute: Splash.RouteName,
        navigatorKey: NavigationService.instance.navigationKey,

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          _localeOverrideDelegate
        ],

        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('fr', ''), // Arabic, no country code
          const Locale('es', ''), // Arabic, no country code
          // ... other locales the app supports
        ],
        // localeResolutionCallback: (locale, supportedLocales){
        //   for(var supportedLocale in supportedLocales){
        //     if(supportedLocale.languageCode == locale.languageCode &&
        //         supportedLocale.countryCode == locale.countryCode){
        //       return supportedLocale;
        //     }
        //   }
        //   return supportedLocales.first;
        // },
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => UndefinedView(
              name: settings.name,
            )),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xffff8a73),
          accentColor : Color(0xff777CEA),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
      );
  }
}
