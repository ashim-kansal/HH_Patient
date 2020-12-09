import 'package:flutter/material.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';

class QuestionairePage extends StatefulWidget{
  static const String RouteName = '/questionaire';

  @override
  State<StatefulWidget> createState() => QuestionairePageState();

}

class QuestionairePageState extends State<QuestionairePage>{

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Questionaire', child:
    Container(
      child: ListView(
        shrinkWrap: true,

        padding: EdgeInsets.all(15),

        children: [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff707070), fontSize: 16),
          ),
          SizedBox(height: 10),
          Container(padding: EdgeInsets.only(left: 10),alignment: Alignment.topCenter,
            child: Expanded(
              child: ListView(
                children: [
                  Text('abcd'),
                  Text('abcd'),
                  Text('abcd'),
                  Text('abcd'),
                  Text('abcd'),
                ],
              )
            )
            ,
          ),
          SizedBox(height: 10),
          HHButton(title: 'Upgrade Now', type: 1, isEnable: true,onClick: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, MyPlans.RouteName, arguments: MyPlansArguments(true));
          },)

        ],
      ),
    )
    );
  }
}