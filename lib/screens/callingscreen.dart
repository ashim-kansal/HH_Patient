
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';


class Calling extends StatefulWidget {
  static const String RouteName = '/callingscreen';

  @override
  State<StatefulWidget> createState() => CallingState();
}


class CallingState extends State<StatefulWidget> {
  IncallManager incallManager = new IncallManager();
  Timer timer;
  String dropdownValue = 'English';
  String newUUID() => Uuid().v4();

  void initState(){
    super.initState();
    incallManager.startRingtone(RingtoneUriType.DEFAULT, 'default', 30);

    timer = Timer(const Duration(seconds: 30), () {
      incallManager.stopRingtone();
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: HH_Colors.color_171717,

            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                     
                      child: Column(
                        children: [
                          Flexible(
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(30.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(color: HH_Colors.color_white)
                                ),
                                child: Image.asset('assets/images/call-p.png', height: 60,width: 60,),
                              )
                            ),
                            flex: 4,
                          ),
                          HHTextView(
                            title: "Calling...",
                            color: HH_Colors.color_white,
                            size: 18,
                            textweight: FontWeight.w500,
                          )
                        
                        ],
                      )
                    ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                      width: 340,
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: new GestureDetector(
                          onTap: () {
                            incallManager.stopRingtone();
                          },
                          child: Image.asset('assets/images/redCall.png', height: 80,width: 80,),
                        )
                      
                      )
                    )
                  ),
              ],
            )
        )
    );
  }


}
