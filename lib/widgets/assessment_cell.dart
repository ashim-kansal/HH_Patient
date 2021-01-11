import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/checkbox_widget.dart';
import 'package:flutter_app/widgets/inputquestion_widget.dart';

class AssessmentCell extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  final VoidCallback onClick;

  AssessmentCell(
      {@required this.name, @required this.role, this.completed, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 18, color: HH_Colors.grey_585858)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Container(
                      width: 70,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: HH_Colors.accentColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: Text(
                        completed ? AppLocalizations.of(context).view : AppLocalizations.of(context).logNow,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: HH_Colors.accentColor),
                      ),
                    ),
                    onTap: () {
                      onClick();
                    },
                  )
                ],
              ),
              Text(
                completed ? AppLocalizations.of(context).submitted : AppLocalizations.of(context).pending,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15,
                    color: completed
                        ? HH_Colors.green_3DDB8C
                        : HH_Colors.primaryColor),
              ),
            ],
          ),
        ));
  }
}

class AssessmentQuestionCell extends StatelessWidget {
  var title = "";
  String quesType;
  var completed = false;
  int num;
  final VoidCallback onClick;
  final ValueChanged<String> onSelectAnswer;

  // typedef void Mycallback(String answer);

  AssessmentQuestionCell(
      {@required this.title,
      @required this.quesType,
      this.completed,
      this.num,
        this.onSelectAnswer,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          quesType == 'text'
              ? InputBoxQuestion(num: num??1, ques:title, onSelectAnswer: onSelectAnswer)
              : quesType == 'YESNO'
                  ? getSingleChoiceQuest(num??1,title)
                  : getMultiChoiceQuest(num??1,title),
        ],
      ),
    );
  }


  Widget getSingleChoiceQuest(int num, String question) {
    return MySingleChoiceQuesWidget(
      num: num,
      ques: question??"",
      onPressYes: () {
        print("yes");
        onSelectAnswer("YES");
      },
      onPressNo: () {
        print("no");
        onSelectAnswer("NO");
      },);
  }

  Widget getMultiChoiceQuest(int num, String question) {
    return CheckBoxQuestion(num:num,ques: question);
  }
}

class MySingleChoiceQuesWidget extends StatefulWidget {

  var ques;
  int num;
  VoidCallback onPressNo;
  VoidCallback onPressYes;

  MySingleChoiceQuesWidget({@required this.ques, this.onPressNo, this.num, this.onPressYes});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();

}

class _MyStatefulWidgetState extends State<MySingleChoiceQuesWidget> {
  var options = ['Yes', 'No'];
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    widget.ques ?? "";
  }

  setSelectedRadio(int val) {
    print("onval");
    print(val);
    setState(() {
      selectedRadio = val;
      if(val == 1)
        widget.onPressYes();
      if(val == 2)
        widget.onPressNo();
    });
  }

  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(
          (widget.num??1).toString()+'. ',
          style: TextStyle(
              fontSize: 18,
              color: HH_Colors.accentColor,
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w500),
        ),
        Flexible(
            child: Text(widget.ques,
                textAlign: TextAlign.start,
                style: TextStyle(color: HH_Colors.grey_707070, fontSize: 16))),
      ]),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 30,
            child: RadioListTile<int>(
              title: Text(AppLocalizations.of(context).yes),
              dense: true,
              // <= here it is !
              value: 1,
              groupValue: selectedRadio,
              activeColor: selectedRadio == "Yes" ? HH_Colors.purpleColor : HH_Colors.accentColor,
              onChanged: (val) {
                // print("Radio $val");
                setSelectedRadio(val);
              },
            ),
          ),
          SizedBox(
            width: 120,
            height: 30,
            child: RadioListTile<int>(
              title: Text(AppLocalizations.of(context).no),
              dense: true,
              // <= here it is !
              value: 2,
              groupValue: selectedRadio,
              activeColor: selectedRadio == "No" ? HH_Colors.purpleColor : HH_Colors.accentColor,
              onChanged: (val) {
                // print("Radio $val");
                setSelectedRadio(val);
              },
            ),
          ),

        ],
      )
    ]);
  }

  getOptions(options, _site) {
    final children = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      children.add(getRadioOption(options[i], _site, () {}));
    }
    return children;
  }

  Widget getRadioOption(String title, String _site, String Function() param2) {
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: _site,
          onChanged: (String value) {},
          activeColor: HH_Colors.grey_707070,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
        ),
      ],
    );
  }
}


class MyMultiChoiceQuesWidget extends StatefulWidget {

  var ques;
  var num;
  var ans;
  VoidCallback onPressNo;
  VoidCallback onPressYes;

  MyMultiChoiceQuesWidget({@required this.ques, @required this.ans, this.onPressNo, this.num, this.onPressYes});

  @override
  StatefulWidgetState createState() => StatefulWidgetState();

}

class StatefulWidgetState extends State<MyMultiChoiceQuesWidget> {
  var options = ['Yes', 'No'];
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    widget.ques ?? "";
  }

  setSelectedRadio(int val) {
    print("onval");
    print(val);
    setState(() {
      selectedRadio = val;
      if(val == 1)
        widget.onPressYes();
      if(val == 2)
        widget.onPressNo();
    });
  }

  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(
          widget.num+'. ',
          style: TextStyle(
              fontSize: 18,
              color: HH_Colors.accentColor,
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w500),
        ),
        Flexible(
            child: Text(widget.ques,
                textAlign: TextAlign.start,
                style: TextStyle(color: HH_Colors.grey_707070, fontSize: 16))),
      ]),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 20,
            child: RadioListTile<int>(
              title: Text("Yes"),
              dense: true,
              // <= here it is !
              value: 1,
              groupValue: selectedRadio,
              activeColor: selectedRadio == "Yes" ? HH_Colors.purpleColor : HH_Colors.accentColor,
              onChanged: (val) {
                // print("Radio $val");
                setSelectedRadio(val);
              },
            ),
          ),
          SizedBox(
            width: 150,
            height: 20,
            child: RadioListTile<int>(
              title: Text("No"),
              dense: true,
              // <= here it is !
              value: 2,
              groupValue: selectedRadio,
              activeColor: selectedRadio == "No" ? HH_Colors.purpleColor : HH_Colors.accentColor,
              onChanged: (val) {
                // print("Radio $val");
                setSelectedRadio(val);
              },
            ),
          ),
        ],
      )
    ]);
  }

  getOptions(options, _site) {
    final children = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      children.add(getRadioOption(options[i], _site, () {}));
    }
    return children;
  }

  Widget getRadioOption(String title, String _site, String Function() param2) {
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: _site,
          onChanged: (String value) {},
          activeColor: HH_Colors.grey_707070,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
        ),
      ],
    );
  }
}