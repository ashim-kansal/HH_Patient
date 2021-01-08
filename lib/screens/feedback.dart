import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';

class FeedbackPage extends StatefulWidget {
  static const String RouteName = '/feedback';

  @override
  State<StatefulWidget> createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  bool isSwitched = false;
  bool error = false;

  TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSwitched ?? true;
  }

  void _feedbackHandler (){

    String feedback = feedbackController.text;

    if(feedback.trim().length == 0){
      setState(() {
        error = true;
      });
      return;
    }

    setState(() {
      error = false;
    });

    SettingAPIService settingAPIService = new SettingAPIService();

    settingAPIService.submitFeedback(feedback).then((value) => {
      showToast(value.responseMsg),
      if (value.responseCode == 200) {
        feedback = "",
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return DialogWithImage(
              title: value.responseMsg,
              onClick: (){
                Navigator.pop(context);
              }
            );
          },
        )
      }
    });
  }

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

@override
Widget build(BuildContext context) => MyWidget(
  title: AppLocalizations.of(context).Contact_Us,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: EdgeInsets.all(20),
        child: Column(children: [
          HHTextView(
            color: HH_Colors.color_707070,
            title: AppLocalizations.of(context).please_contact_us,
            size: 16,
              textweight:FontWeight.w600
          ),
          SizedBox(
            height: 10,
          ),
          HHEditText(
            minLines: 5,
            controller: feedbackController,
            error: error,
            errorText: AppLocalizations.of(context).please_enter_feedback,
          ),
      ])),
      Container(
        margin: EdgeInsets.only(left: 20, right: 30),
        child:       HHButton(title: AppLocalizations.of(context).send, type: 4, onClick: () => {
          _feedbackHandler()
        },)
      )
    ],
  ));
}