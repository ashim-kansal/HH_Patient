import 'dart:async';
import 'dart:io';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/services/navigation_service.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final FlutterCallkeep _callKeep = FlutterCallkeep();
bool _callKeepInited = false;

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('backgroundMessage: message => ${message.toString()}');
  var payload = message['data'];
  var callerId = payload['caller_id'] as String;
  var callerNmae = payload['caller_name'] as String;
  var uuid = payload['uuid'] as String;
  var hasVideo = payload['has_video'] == "true";

  final callUUID = uuid ?? Uuid().v4();
  _callKeep.on(CallKeepPerformAnswerCallAction(),
      (CallKeepPerformAnswerCallAction event) {
    print(
        'backgroundMessage: CallKeepPerformAnswerCallAction ${event.callUUID}');
    _callKeep.startCall(event.callUUID, callerId, callerNmae);

    Timer(const Duration(seconds: 1), () {
      print(
          '[setCurrentCallActive] $callUUID, callerId: $callerId, callerName: $callerNmae');
      _callKeep.setCurrentCallActive(callUUID);
    });
    //_callKeep.endCall(event.callUUID);
  });

  _callKeep.on(CallKeepPerformEndCallAction(),
      (CallKeepPerformEndCallAction event) {
    print('backgroundMessage: CallKeepPerformEndCallAction ${event.callUUID}');
  });
  if (!_callKeepInited) {
    _callKeep.setup(<String, dynamic>{
      'ios': {
        'appName': 'HHPatient',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      },
    });
    _callKeepInited = true;
  }

  print('backgroundMessage: displayIncomingCall ($callerId)');
  _callKeep.displayIncomingCall(callUUID, callerId,
      localizedCallerName: callerNmae, hasVideo: hasVideo);
  _callKeep.backToForeground();

  return null;
}

class Call {
  Call(this.number);
  String number;
  bool held = false;
  bool muted = false;
}



// @override
// void setupLocator() {
//   locator.registerLazySingleton(() => NavigationService());
// }

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

  final FlutterCallkeep _callKeep = FlutterCallkeep();
  Map<String, Call> calls = {};
  String newUUID() => Uuid().v4();

  // Future<bool> showLoginPage() async {
  //   var sharedPreferences = await SharedPreferences.getInstance();
  //   String user = sharedPreferences.getString('token');

  //   print('user Token $user');
  // }

  _register() {
    
    _firebaseMessaging.getToken().then((fcmtoken) => {
      SetStringToSP("deviceToken", fcmtoken),
      // HelperFunction.saveAuthorizationToken(fcmtoken),
      print(fcmtoken)
    });
  }

  getToken() {
    getAppToken().then((value) =>setState(() {
      token = value;
    }));

    // setState(() {
    //   token = userToken;
    // });
    // token = userToken;
    print(token);
  }

  static BuildContext mContext; 

  @override
  void initState() {
    super.initState();
    // showLoginPage();
    
    //callkit
    _callKeep.on(CallKeepDidDisplayIncomingCall(), didDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), answerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), didPerformDTMFAction);
    _callKeep.on(
        CallKeepDidReceiveStartCallAction(), didReceiveStartCallAction);
    _callKeep.on(CallKeepDidToggleHoldAction(), didToggleHoldCallAction);
    _callKeep.on(
        CallKeepDidPerformSetMutedCallAction(), didPerformSetMutedCallAction);
    _callKeep.on(CallKeepPerformEndCallAction(), endCall);
    _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

    _callKeep.setup(<String, dynamic>{
      'ios': {
        'appName': 'HHPatient',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      },
    });
    //end callkit




    getToken();
    _register();
    // getMessage();

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

  void removeCall(String callUUID) {
    setState(() {
      calls.remove(callUUID);
    });
  }

  void setCallHeld(String callUUID, bool held) {
    setState(() {
      calls[callUUID].held = held;
    });
  }

  void setCallMuted(String callUUID, bool muted) {
    setState(() {
      calls[callUUID].muted = muted;
    });
  }

  Future<void> answerCall(CallKeepPerformAnswerCallAction event) async {
    
    
    final String callUUID = event.callUUID;
    final String number = calls[callUUID].number;
    
    print('[answerCall] $callUUID, number: $number');
    print("objSess $sessionObj");
    _callKeep.backToForeground();
    _callKeep.endAllCalls();
    try{
      navigateH();
     
    }catch (err){
      print('push to new route error ${err.toString()}');
    }
  //  return;

    // _callKeep.startCall(event.callUUID, number, number);
    // Timer(const Duration(seconds: 1), () {
    //   print('[setCurrentCallActive] $callUUID, number: $number');
    //   print(sessionObj);

    //   _callKeep.setCurrentCallActive(callUUID);
    // });
  }

  Future<void> endCall(CallKeepPerformEndCallAction event) async {
    print('endCall: ${event.callUUID}');
    removeCall(event.callUUID);
  }

  Future<void> didPerformDTMFAction(CallKeepDidPerformDTMFAction event) async {
    print('[didPerformDTMFAction] ${event.callUUID}, digits: ${event.digits}');
  }

  Future<void> didReceiveStartCallAction(
      CallKeepDidReceiveStartCallAction event) async {
    if (event.handle == null) {
      // @TODO: sometime we receive `didReceiveStartCallAction` with handle` undefined`
      return;
    }
    final String callUUID = event.callUUID ?? newUUID();
    // setState(() {
    //   calls[callUUID] = Call(event.handle);
    // });
    print('[didReceiveStartCallAction] $callUUID, number: ${event.handle}');

    _callKeep.startCall(callUUID, event.handle, event.handle);

    Timer(const Duration(seconds: 1), () {
      print('[setCurrentCallActive] $callUUID, number: ${event.handle}');
      _callKeep.setCurrentCallActive(callUUID);
    });
  }

  Future<void> didPerformSetMutedCallAction(
      CallKeepDidPerformSetMutedCallAction event) async {
    final String number = calls[event.callUUID].number;
    print(
        '[didPerformSetMutedCallAction] ${event.callUUID}, number: $number (${event.muted})');

    setCallMuted(event.callUUID, event.muted);
  }

   Future<void> didToggleHoldCallAction(
      CallKeepDidToggleHoldAction event) async {
    final String number = calls[event.callUUID].number;
    print(
        '[didToggleHoldCallAction] ${event.callUUID}, number: $number (${event.hold})');

    setCallHeld(event.callUUID, event.hold);
  }

  Future<void> hangup(String callUUID) async {
    _callKeep.endCall(callUUID);
    removeCall(callUUID);
  }

  Future<void> setOnHold(String callUUID, bool held) async {
    _callKeep.setOnHold(callUUID, held);
    final String handle = calls[callUUID].number;
    print('[setOnHold: $held] $callUUID, number: $handle');
    setCallHeld(callUUID, held);
  }

  Future<void> setMutedCall(String callUUID, bool muted) async {
    _callKeep.setMutedCall(callUUID, muted);
    final String handle = calls[callUUID].number;
    print('[setMutedCall: $muted] $callUUID, number: $handle');
    setCallMuted(callUUID, muted);
  }

  Future<void> updateDisplay(String callUUID) async {
    final String number = calls[callUUID].number;
    // Workaround because Android doesn't display well displayName, se we have to switch ...
    if (isIOS) {
      _callKeep.updateDisplay(callUUID,
          displayName: 'New Name', handle: number);
    } else {
      _callKeep.updateDisplay(callUUID,
          displayName: number, handle: 'New Name');
    }

    print('[updateDisplay: $number] $callUUID');
  }

  Future<void> displayIncomingCallDelayed(String number) async {
    Timer(const Duration(seconds: 3), () {
      displayIncomingCall(number);
    });
  }

  Future<void> displayIncomingCall(String number) async {
    final String callUUID = newUUID();
    // setState(() {
      calls[callUUID] = Call(number);
    // });
    print('Display incoming call now');
    final bool hasPhoneAccount = await _callKeep.hasPhoneAccount();
    if (!hasPhoneAccount) {
      await _callKeep.hasDefaultPhoneAccount(context, <String, dynamic>{
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      });
    }

    print('[displayIncomingCall] $callUUID number: $number');
    _callKeep.displayIncomingCall(callUUID, number,
        handleType: 'number', hasVideo: false);
  }

  void didDisplayIncomingCall(CallKeepDidDisplayIncomingCall event) {
    var callUUID = event.callUUID;
    var number = event.handle;
    print('[displayIncomingCall] $callUUID number: $number');
    // setState(() {
    //   calls[callUUID] = Call(number);
    // });
  }

  void onPushKitToken(CallKeepPushKitToken event) {
    SetStringToSP("voipToken", event.token);
    print('[onPushKitToken] token => ${event.token}');
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
              // Navigator.pushNamed(context, MyPlans.RouteName, arguments: MyPlansArguments(false))
              Navigator.pushNamed(context, SelectLanguage.RouteName)
            },
      }
    );
  }

  void getMessage(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');

        if(Platform.isAndroid){
          print(message["data"]["type"]);
          if(message["data"]["type"].toString() == "incoming_call"){
            Client rnd = Client(identity: message["data"]["receiverId"], programname: message["data"]["programName"], roomname: message["data"]["room"], token: message["data"]["AccessToken"]);
            await DBProvider.db.newClient(rnd);
            Timer(Duration(seconds: 1),
                    ()=>{
                  displayIncomingCall("10086")
                });
          }
        }else{
          print(message["type"]);
          if(message["type"].toString() == "incoming_call"){
            Client rnd = Client(identity: message["receiverId"], programname: message["programName"], roomname: message["room"], token: message["AccessToken"]);
            await DBProvider.db.newClient(rnd);
            Timer(Duration(seconds: 1),
                    ()=>{
                  displayIncomingCall("10086")
                });
          }
        }
        // setState(() => _message = message["notification"]["title"]);
      }, onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        if(message["type"].toString() == "incoming_call"){
          Client rnd = Client(identity: message["receiverId"], programname: message["programName"], roomname: message["room"], token: message["AccessToken"]);
          await DBProvider.db.newClient(rnd);
          Timer(Duration(seconds: 1),
          ()=>{
            displayIncomingCall("10086")
          });
        }
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        if(message["type"].toString() == "incoming_call"){
          Client rnd = Client(identity: message["receiverId"], programname: message["programName"], roomname: message["room"], token: message["AccessToken"]);
          await DBProvider.db.newClient(rnd);
          Timer(Duration(seconds: 1),
          ()=>{
            displayIncomingCall("10086")
          });
        }
        // setState(() => _message = message["notification"]["title"]);
      }
    );
  }

  void navigateH() async {
    var storageRes; 
    var sessionObj = await GetStringToSP("sMsg");
    print('object in msg $sessionObj');

    DBProvider.db.getAllClients().then((value) => {
      // storageRes = clientToJson(value),
      storageRes = value,
      print("clientRes11" +value.identity),
      // print("clientRes" +storageRes.toString()),

      NavigationService.instance.navigateToRoute(MaterialPageRoute(
        builder: (context) => VideoCallPage(identity: value.identity, roomName: value.roomname, token: value.token),
      )),
    });
    // Navigator.pushNamed(mContext, VideoCallPage.RouteName, arguments: VideoPageArgument(sessionObj["receiverId"], sessionObj["room"], sessionObj["AccessToken"]))
    //       .then((value) => {
    //         Navigator.pushNamed(mContext, ReviewPage.RouteName, arguments: ReviewPageArgument(sessionObj["room"].split("/").last, sessionObj["programName"]))
    //   });
  }

  @override
  Widget build(BuildContext context) {
    // HelperFunction.getAuthorizationToken(context).then((value) => {
    // print('mtttttttt  :'+value)
    //
    // });
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


