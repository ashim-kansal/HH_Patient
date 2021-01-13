import 'package:flutter/material.dart';
import 'package:flutter_app/api/Assessment_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/screens/assessment_form.dart';
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
    return FutureBuilder<GetAssessmentResponse>(
        future: getAllAssessments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(AppLocalizations.of(context).error),);
            }
            return Container(
              child: ListView.separated(
                itemCount: snapshot.data.results.length,
                itemBuilder: (context, index) {
                  return AssessmentCell(name: snapshot.data.results[index].title, completed: snapshot.data.results[index].isSubmit, 
                  onClick: (){
                    Navigator.pushNamed(context, AssessmentFormPage.RouteName, arguments: AssessmentArguments(
                        snapshot.data.results[index]
                    )).then((value)=>{
                    setState(() {

                    })
                    });
                  },);

                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),);


          } else
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
        });

  }
}
