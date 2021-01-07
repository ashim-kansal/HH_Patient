import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/QuestionarieModel.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/checkbox_widget.dart';
import 'package:flutter_app/widgets/inputquestion_widget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class QuestionairePage extends StatefulWidget {
  static const String RouteName = '/questionaire';
  Result result;
  Future<QuestionarieList> _listFuture;

  String programId;
  QuestionairePage({this.programId});

  @override
  State<StatefulWidget> createState() => QuestionairePageState();
}

class QuestionairePageState extends State<QuestionairePage> {

  @override
  void initState() {
    widget.result??Result();

    widget._listFuture = getQuestionaire(widget.programId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: HHString.Questionaire,
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
                    future: widget._listFuture,
                    builder: (builder, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasError){
                          return Center(child: Text(HHString.error),);
                        }
                        SchedulerBinding.instance.addPostFrameCallback((_){

                          setState(() {
                            widget.result = snapshot.data.result[0];
                          });

                        });
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            if(snapshot.data.result[0].questions[index].questionType == "text"){
                              return getQues(InputBoxQuestion(num: index+1, ques: snapshot.data.result[0].questions[index].questionText, onSelectAnswer: (answer){
                                widget.result.questions[index].Answer = answer;
                              },));
                            }else if(snapshot.data.result[0].questions[index].questionType == "YESNO"){
                              return getQues(AssessmentQuestionCell(
                                  num: index+1,
                                  title: snapshot.data.result[0].questions[index].questionText,
                                  onSelectAnswer: (answer){
                                    widget.result.questions[index].Answer = answer;
                              },
                                  quesType: snapshot.data.result[0].questions[index].questionType,
                                  completed: false
                              ));
                            }else {
                              return  getQues(CheckBoxQuestion(
                                num: index+1,
                                ques: snapshot.data.result[0].questions[index].questionText,
                                options: snapshot.data.result[0].questions[index].options,
                                onSelectAnswers: (answer){
                                  widget.result.questions[index].options = answer;
                                },),
                              );
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
                title: HHString.submit_proceed,
                type: 4,
                isEnable: true,
                onClick: () {
                 submitForm();
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

  void submitForm() async {

    print("data");
    print(widget.result);

    // submitAssessments(data);
    submitQuestionaire(widget.result).then(
            (value) => {

          print(value.responseCode),
          if (value.responseCode == 200) {
            Navigator.pop(context),
            Navigator.pushNamed(context, Dashboard.RouteName)
          }
        });
  }
}


class QuestionaireArguments {
  final String programId;

  QuestionaireArguments(this.programId);
}
