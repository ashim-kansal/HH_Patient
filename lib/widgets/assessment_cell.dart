import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        SizedBox(
                            width: 250,
                            child: Text(name,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: HH_Colors.grey_585858)))
                      ]),
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
                            completed ? 'Log Now' : 'View',
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
            ],
          ),
        ));
  }
}

class AssessmentQuestionCell extends StatelessWidget {
  var title = "";
  int quesType;
  var completed = false;
  final VoidCallback onClick;

  AssessmentQuestionCell({@required this.title,
    @required this.quesType,
    this.completed,
    this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style:
              TextStyle(fontSize: 16, color: HH_Colors.grey_707070)),
          quesType == 0 ? getInputQuest() : quesType == 1
              ? getSingleChoiceQuest()
              : getMultiChoiceQuest(),
        ],
      ),
    );
  }

  Widget getInputQuest() {
    return Container();
  }

  Widget getSingleChoiceQuest() {
    return MySingleChoiceQuesWidget();
  }

  Widget getMultiChoiceQuest() {
    return Container();
  }
}

class MySingleChoiceQuesWidget extends StatefulWidget {

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MySingleChoiceQuesWidget> {
  var options= ['Yes', 'No'];

  Widget build(BuildContext context) {
    String _site = options[0];

    return Row(
      children: getOptions(options, _site),
    );
  }

  getOptions(options, _site) {
    final children = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      children.add(getRadioOption(options[i], _site, (){}));
    }
    return children;
  }
  Widget getRadioOption(String title, String _site, String Function() param2){
    return Row(
      children: [
    Radio(
    value: title,
    groupValue: _site,
    onChanged: (String value) {

    },
    activeColor: HH_Colors.grey_707070,
    ),
        Text(title, style: TextStyle(fontSize: 16,color: HH_Colors.grey_707070),),

      ],
    );
  }

}