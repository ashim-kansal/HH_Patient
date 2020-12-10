import 'package:flutter/material.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/checkbox_widget.dart';
import 'package:flutter_app/widgets/inputquestion_widget.dart';
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
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: HH_Colors.grey_707070, fontSize: 16),
          ),
          SizedBox(height: 10),
Expanded(
              child: ListView(
                children: [
                  InputBoxQuestion(ques:'abcd'),
                  InputBoxQuestion(ques:'abcd'),
                  CheckBoxQuestion(ques: 'abcd'),
                  // CheckBoxQuestion(ques: 'abcd'),
                  MySingleChoiceQuesWidget(),
                  MySingleChoiceQuesWidget(),
                ],
              )
            )
            ,

          SizedBox(height: 10),
          HHButton(title: 'Upgrade Now', type: 1, isEnable: true,onClick: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, Dashboard.RouteName);
          },)

        ],
      ),
    )
    );
  }
}