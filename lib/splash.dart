import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/agora/permissions.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/services/navigation_service.dart';
import 'package:flutter_app/utils/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}


class Splash extends StatefulWidget{

  static const String RouteName = '/';

  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{

  String data = "";
  String nameKey = "_key_name";
  String token;
  String _message = '';
  var sessionObj = {};
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  _registerFCM() async {

    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    
       _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    }

    _firebaseMessaging.getToken().then((fcmtoken) => {
      SetStringToSP("deviceToken", fcmtoken),
      print(fcmtoken)
    });
    _firebaseMessaging.subscribeToTopic("matchscore");
  }

  getToken() {
    getAppToken().then((value) =>setState(() {
      token = value;
    }));

    print(token);
  }

  static BuildContext mContext; 

  @override
  void initState() {
    super.initState();

    getToken();
    _registerFCM();
    getMessage();
    Permissions.cameraAndMicrophonePermissionsGranted();
    Firebase.initializeApp();

    SharedPreferences.setMockInitialValues({});
    //
    const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler(
      (MethodCall methodcall) async {
        if (methodcall.method == 'getAll') {
          return {"flutter." + nameKey: "[ No Name Saved ]"};
        }
        return null;
      },
    );

    checkIfUserLoggedIn();


  }


  Future checkIfUserLoggedIn()async {
    
    var accessToken = await GetStringToSP("token");
    print("accessToken for app $accessToken");
     Timer(Duration(seconds: 4),
      ()=>{
        print("accessToken for app22 $accessToken"),
            Navigator.pop(context),
            if (accessToken != null) {
              Navigator.pushNamed(context, Dashboard.RouteName)
            }else{
              Navigator.pushNamed(context, SelectLanguage.RouteName)
            },
      }
    );
  }

  Future getMessage() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Container(
        color: Color(0xff777CEA),
        child: Center(
          child: Image.asset('assets/images/ic_appicon_white.png',
          height: 100,
          width: 150,
        ),
        )
      ),
      navigatorKey: navigatorKey,
    );
      
  }


}



