import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/QuestionarieModel.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/inputquestion_widget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class QuestionairePage extends StatefulWidget {
  static const String RouteName = '/questionaire';

  String programId;
  QuestionairePage({this.programId});

  @override
  State<StatefulWidget> createState() => QuestionairePageState();
}

class QuestionairePageState extends State<QuestionairePage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: 'Questionaire',
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                HHString.sample_ques,
                textAlign: TextAlign.center,
                style: TextStyle(color: HH_Colors.grey_707070, fontSize: 16),
              ),
              SizedBox(height: 10),
              Expanded(
                child: 
                // Column(
                // children: [
                //   // LinearProgressIndicator(
                //   //   minHeight: 5,
                //   //   backgroundColor: HH_Colors.color_F2EEEE,
                //   //   valueColor: AlwaysStoppedAnimation(HH_Colors.primaryColor),
                //   // ),
                //   SizedBox(
                //     height: 5,
                //   ),
                  FutureBuilder<QuestionarieList>(
                    future: getQuestionaire(widget.programId),
                    builder: (builder, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasError){
                          return Text("Error"); 
                        }
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            if(snapshot.data.result[0].questions[index].questionType == "text"){
                              return getQues(InputBoxQuestion(ques: snapshot.data.result[0].questions[index].questionText));
                            }else if(snapshot.data.result[0].questions[index].questionType == "YESNO"){
                              return getQues(MySingleChoiceQuesWidget(ques: snapshot.data.result[0].questions[index].questionText));
                            }else {
                              return  getQues(MyMultiChoiceQuesWidget(
                                ques: snapshot.data.result[0].questions[index].questionText,
                                ans: snapshot.data.result[0].questions[index].options));
                            }
                          }, 
                          itemCount: snapshot.data.result[0].questions.length, 
                          separatorBuilder: (BuildContext context, int index) {  return SizedBox(height: 5); },
                        ); 
                      }else {
                        return Container(
                          child: Center(child: CircularProgressIndicator(),),
                        );
                      }
                  }),
                  // getQues(InputBoxQuestion(ques: HHString.sample_ques)),
                  // getQues(InputBoxQuestion(ques: HHString.sample_ques)),
                  // // getQues(CheckBoxQuestion(ques:HHString.sample_ques)),
                  // getQues(MySingleChoiceQuesWidget(ques: HHString.sample_ques)),
                  // getQues(MySingleChoiceQuesWidget(ques: HHString.sample_ques)),
              //   ],
              // )
              ),
              SizedBox(height: 10),
              HHButton(
                title: 'Submit & Proceed',
                type: 4,
                isEnable: true,
                onClick: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Dashboard.RouteName);
                },
              )
            ],
          ),
        ));
  }

  Widget getQues(Widget child) {
    return Card(
      elevation: 2,
      child: Padding(
        child: child,
        padding: EdgeInsets.all(5),
      ),
    );
  }
}


class QuestionaireArguments {
  final String programId;

  QuestionaireArguments(this.programId);
}
