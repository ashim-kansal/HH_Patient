import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class SessionCard extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  final VoidCallback onClick;

  SessionCard(
      {@required this.name, @required this.role, this.completed, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
        child: Card(
        elevation: 5,
            color: HH_Colors.color_F2EEEE,

            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('22 Nov, 2020, 1:30 PM', style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070),),
                  Image.asset('assets/images/ic_option_menu.png', width: 20, height: 20,)
                ],

              ),
              SizedBox(height: 10,),
              Row(
                children: [Text('Group therapy to Patient 1' ,textAlign:TextAlign.start,style: TextStyle(fontSize: 16, color: HH_Colors.grey_585858)),
              ]),
              Row(
                children: [Text('Dr. Ian Newton' ,textAlign:TextAlign.start,style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070)),
              ]),
              Row(
                children: [
                  ButtonTheme(
                    height: 35,
                    minWidth: 35,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Icon(Icons.chat, color: HH_Colors.primaryColor, size: 18,),
                      onPressed: (){
                        // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                      },
                      shape: CircleBorder(),

                    ),
                  ),

                  ButtonTheme(
                    height: 35,
                    minWidth: 35,
                    child: RaisedButton(

                      color: Colors.white,
                      child: Icon(Icons.video_call, color: HH_Colors.primaryColor,size: 18,),
                      onPressed: (){
                        // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                      },
                      shape: CircleBorder()
                    )),

                ],
              )

            ],
          ),
        )));
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

class UpcomingSessionItem extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  final VoidCallback onClick;

  UpcomingSessionItem(
      {@required this.name, @required this.role, this.completed, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('AMS Therapy',textAlign:TextAlign.start, style: TextStyle(fontSize: 16, color: HH_Colors.grey_585858),),
                        ],
                      ),
                      Row(
                        children: [
                          Text('22 Nov, 2020, 1:30 PM',textAlign:TextAlign.start, style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070),),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      ButtonTheme(
                        height: 35,
                        minWidth: 35,
                        child: RaisedButton(
                          color: Colors.white,
                          child: Icon(Icons.chat, color: HH_Colors.primaryColor, size: 18,),
                          onPressed: (){
                            // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                          },
                          shape: CircleBorder(),

                        ),
                      ),

                      ButtonTheme(
                          height: 35,
                          minWidth: 35,
                          child: RaisedButton(

                              color: Colors.white,
                              child: Icon(Icons.video_call, color: HH_Colors.primaryColor,size: 18,),
                              onPressed: (){
                                // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                              },
                              shape: CircleBorder()
                          )),
                      Image.asset('assets/images/ic_option_menu.png', width: 20, height: 20,)

                    ],
                  )
                ],

              ),


            )));
  }
}