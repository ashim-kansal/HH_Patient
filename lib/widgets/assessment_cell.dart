import 'package:flutter/material.dart';
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
                        completed ? 'View' : 'Log Now',
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
                completed ? 'Submitted' : 'Pending',
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
  final VoidCallback onClick;

  AssessmentQuestionCell(
      {@required this.title,
      @required this.quesType,
      this.completed,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          quesType == 'text'
              ? getInputQuest(title)
              : quesType == 'YESNO'
                  ? getSingleChoiceQuest(title)
                  : getMultiChoiceQuest(title),
        ],
      ),
    );
  }

  Widget getInputQuest(String question) {
    return InputBoxQuestion(ques: question);
  }

  Widget getSingleChoiceQuest(String question) {
    return MySingleChoiceQuesWidget(
      ques: question,
      onPressYes: () {
        print("yes");
      },
      onPressNo: () {
        print("no");
      },);
  }

  Widget getMultiChoiceQuest(String question) {
    return CheckBoxQuestion(ques: question);
  }
}

class MySingleChoiceQuesWidget extends StatefulWidget {

  var ques;
  VoidCallback onPressNo;
  VoidCallback onPressYes;

  MySingleChoiceQuesWidget({@required this.ques, this.onPressNo, this.onPressYes});

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
          'Q. ',
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
          // Row(
          //   children: [
          // Radio(
          //   value: 2,
          //   groupValue: selectedRadio,
          //   activeColor: HH_Colors.accentColor,
          //   onChanged: (val) {
          //     print("Radio $val");
          //     setSelectedRadio(val);
          //   },
          // ),
          //     Text('No')
          //   ],
          // )
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
