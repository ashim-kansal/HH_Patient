import 'package:flutter/material.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';

class MyPlans extends StatefulWidget {
  static const String RouteName = '/planwidget';

  var isUpdate = false;

  MyPlans({
    Key key,
    @required this.isUpdate
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => MyPlansState();
}

class MyPlansState extends State<MyPlans> {
  var pagerController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: HHString.hh, child: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff707070), fontSize: 16),
          ),
        ),
        Expanded(
            child: PageView(
              controller: pagerController,
              children: [
                PlanWidget(title: HHString.programHeading, program_type: HHString.program, desc: HHString.desc, price: 0, onClick: (){
                  if(widget.isUpdate)
                    Navigator.pop(context);
                  else
                    Navigator.pushNamed(context, QuestionairePage.RouteName);

                },),
                PlanWidget(title: HHString.programHeading, program_type: HHString.program, desc: HHString.desc, price: 1, onClick: (){}),
                PlanWidget(title: HHString.programHeading, program_type: HHString.program, desc: HHString.desc, price: 2, onClick: (){}),

              ],
            )),
      ],
    ));
  }
}

class MyPlansArguments {

  final bool isUpdate;

  MyPlansArguments(this.isUpdate);
}

