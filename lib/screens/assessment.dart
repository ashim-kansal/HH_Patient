import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';

class MyAssessmentPage extends StatefulWidget{
  static const String RouteName = '/assessments';

  final assessments = ['AUDIT (Alcohol Use Disorder Identification Test)', 'Michigan Alcohol Test', 'AUDIT (Alcohol Use Disorder Identification Test)', 'Michigan Alcohol Test', ];

  @override
  State<StatefulWidget> createState() =>MyAssessmentState();
}

class MyAssessmentState extends State<MyAssessmentPage>{

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'My Assessments',
    child: Container(
      height: 20,
      width: 50,
      decoration: BoxDecoration(
        color: HH_Colors.accentColor,
        shape: BoxShape.rectangle,
        border: Border.all(color: HH_Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0))),

    ),
    //   child:
    //   ListView.separated(
    //   itemCount: widget.assessments.length,
    //   itemBuilder: (context, index) {
    //     return AssessmentCell(name: widget.assessments[index], completed: index%2 == 0, onClick: (){
    //       // Navigator.pushNamed(context, BookSessionPage.RouteName);
    //     },);
    //
    //   },
    //   separatorBuilder: (context, index) {
    //     return Divider();
    //   },
    // ),
    );
  }
}