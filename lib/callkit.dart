import 'dart:async';

import 'package:callkeep/callkeep.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

class CallKit extends StatefulWidget {
  static const String RouteName = '/language';

  @override
  State<StatefulWidget> createState() => CallKitState();
}

class CallKitState extends State<StatefulWidget> {
  String dropdownValue = 'English';

  final FlutterCallkeep _callKeep = FlutterCallkeep();
  Map<String, Call> calls = {};
  String newUUID() => Uuid().v4();

  void initState(){
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
    _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

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

  void onPushKitToken(CallKeepPushKitToken event) {
    print('[onPushKitToken] token => ${event.token}');
  }

  Widget buildCallingWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: calls.entries
          .map((MapEntry<String, Call> item) =>
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('number: ${item.value.number}'),
                Text('uuid: ${item.key}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        setOnHold(item.key, !item.value.held);
                      },
                      child: Text(item.value.held ? 'Unhold' : 'Hold'),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        updateDisplay(item.key);
                      },
                      child: const Text('Display'),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        setMutedCall(item.key, !item.value.muted);
                      },
                      child: Text(item.value.muted ? 'Unmute' : 'Mute'),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        hangup(item.key);
                      },
                      child: const Text('Hangup'),
                    ),
                  ],
                )
              ]))
          .toList());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}