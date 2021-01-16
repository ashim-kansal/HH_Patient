import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/callkit.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:callkeep/callkeep.dart';
import 'package:uuid/uuid.dart';


class SelectLanguage extends StatefulWidget {
  static const String RouteName = '/language';

  @override
  State<StatefulWidget> createState() => SelectLanguageState();
}

final FlutterCallkeep _callKeep = FlutterCallkeep();
bool _callKeepInited = false;

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
        'appName': 'CallKeepDemo',
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
  /*

  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print('notification => ${notification.toString()}');
  }

  // Or do other work.
  */
  return null;
}


class Call {
  Call(this.number);
  String number;
  bool held = false;
  bool muted = false;
}

class SelectLanguageState extends State<StatefulWidget> {
  String dropdownValue = 'English';

  final FlutterCallkeep _callKeep = FlutterCallkeep();
  bool _callKeepInited = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  Map<String, Call> calls = {};
  String newUUID() => Uuid().v4();

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

    _callKeep.startCall(event.callUUID, number, number);
    Timer(const Duration(seconds: 1), () {
      print('[setCurrentCallActive] $callUUID, number: $number');
      _callKeep.setCurrentCallActive(callUUID);
    });
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
    setState(() {
      calls[callUUID] = Call(event.handle);
    });
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
    setState(() {
      calls[callUUID] = Call(number);
    });
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
    setState(() {
      calls[callUUID] = Call(number);
    });
  }

  @override
  void initState() {
    super.initState();
    _callKeep.on(CallKeepDidDisplayIncomingCall(), didDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), answerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), didPerformDTMFAction);
    _callKeep.on(
        CallKeepDidReceiveStartCallAction(), didReceiveStartCallAction);
    _callKeep.on(CallKeepDidToggleHoldAction(), didToggleHoldCallAction);
    _callKeep.on(
        CallKeepDidPerformSetMutedCallAction(), didPerformSetMutedCallAction);
    _callKeep.on(CallKeepPerformEndCallAction(), endCall);
    // _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

    _callKeep.setup(<String, dynamic>{
      'ios': {
        'appName': 'CallKeepDemo',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      },
    });

    // if (Platform.isAndroid) {
    //   //if (isIOS) iOS_Permission();
    //   //  _firebaseMessaging.requestNotificationPermissions();

    //   _firebaseMessaging.getToken().then((token) {
    //     print('[FCM] token => ' + token);
    //   });

    //   _firebaseMessaging.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //       print('onMessage: $message');
    //       if (message.containsKey('data')) {
    //         // Handle data message
    //         final dynamic data = message['data'];
    //         var number = data['body'] as String;
    //         await displayIncomingCall(number);
    //       }
    //     },
    //     onBackgroundMessage: myBackgroundMessageHandler,
    //     onLaunch: (Map<String, dynamic> message) async {
    //       print('onLaunch: $message');
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print('onResume: $message');
    //     },
    //   );
    // }
  }

  
  // Future<void> displayIncomingCall(BuildContext context) async {

  //   await CallKeep.setup();
  //   await CallKeep.askForPermissionsIfNeeded(context);
  //   final callUUID = '0783a8e5-8353-4802-9448-c6211109af51';
  //   final number = '+46 70 123 45 67';

  //   await CallKeep.displayIncomingCall(
  //       callUUID, number, number, HandleType.number, false);
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color(0xfff2eeee),

            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Center(
                                child:Image.asset('assets/images/ic_appicon_blue.png', height: 180,width: 150,)
                            ),
                            flex: 4,
                          ),
                          Flexible(
                            child: Material(
                              color: Colors.white,
                              child: Column(children: [
                                Text(
                                  AppLocalizations.of(context).selectLang,
                                  style: TextStyle(color: Color(0xff949494), fontSize: 16,
                                    fontFamily:"ProximaNova"
                                    ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  padding:  const EdgeInsets.only(left: 20.0,right: 10.0),
                                  width: 230.0,
                                  // padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Color(0xffE9E7E7)),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0))),

                                child: DropdownButtonHideUnderline(

                                  child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconEnabledColor: Color(0xffC5C4C4),
                                  iconSize: 38,
                                  elevation: 16,
                                  style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                  onChanged: (String newValue) {
                                    SetStringToSP("language", newValue);
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>['English',  'Français', 'Español']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),)
                                )
                              ],)

                            ),
                            flex: 1,
                          )
                        ],
                      )),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                        width: 340,
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: HHButton(title: AppLocalizations.of(context).get_started,
                          type: 2, 
                          isEnable: true,
                          onClick: () async {
                            CallKit callKit = new CallKit();
                            displayIncomingCall("100888");
                            // String lang = dropdownValue== 'English' ? "en" : dropdownValue==  'Français' ? 'fr' :'es';
                            // SetStringToSP("language", lang.toLowerCase());
                            // setState(() {
                            //   AppLocalizations.load(Locale(lang, ''));
                            // });
                            // Navigator.pop(context);
                            // Navigator.pushNamed(context, MyGoals.RouteName);
                          }),
                        ))),
              ],
            )
        )
    );
  }


}
