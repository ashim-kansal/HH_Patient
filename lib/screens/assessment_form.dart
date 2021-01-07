import 'package:flutter/material.dart';
import 'package:flutter_app/api/Assessment_services.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart' as Response;
import 'package:flutter_app/model/SubmittedAssessmentResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter/scheduler.dart';


class AssessmentFormPage extends StatefulWidget {
  static const String RouteName = '/assessment_form';

  Response.Result data;

  AssessmentFormPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssessmentFormState();
}

class AssessmentFormState extends State<AssessmentFormPage> {
  Result mFormData;
  Future<SubmittedAssessmentResponse> apiCall;

  @override
  void initState() {
    super.initState();
    apiCall = widget.data.isSubmit ? getSubmittedAssessmentForm(widget.data.formId): getAssessmentForm(widget.data.formId);
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: widget.data.title,
        child: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<SubmittedAssessmentResponse>(
              future: apiCall,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text(HHString.error),);
                  }

                  SchedulerBinding.instance.addPostFrameCallback((_){
                    setState(() {
                      mFormData = snapshot.data.result;
                    });
                  });
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data.result.title,
                        style: TextStyle(
                            fontSize: 22,
                            color: HH_Colors.accentColor,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.separated(
                            itemCount: snapshot.data.result.questions.length,
                            itemBuilder: (context, index) {
                              return widget.data.isSubmit
                                  ? buildContainerForQuestionWithAnswer(index+1, snapshot.data.result.questions[index])
                                  : buildAssessmentQuestionCellForAnswer(index+1, snapshot.data.result.questions[index]);
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      widget.data.isSubmit
                          ? Container()
                          : HHButton(
                          title: HHString.submit, type: 2, isEnable: true, onClick: () {submitForm();
                      }),
                    ],
                  );


                } else
                  return Container(
                    child: Center(child: CircularProgressIndicator(),),
                  );
              }),
        ));
  }

  Column buildContainerForQuestionWithAnswer(int index, Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(index.toString()+'. '+question.questionText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 16,
                color: HH_Colors.grey_707070,
                fontFamily: "ProximaNova")),
        Text(question.answer,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 16,
                color: HH_Colors.grey_707070,
                fontWeight: FontWeight.w600,
                fontFamily: "ProximaNova"))
      ],
    );
  }

  AssessmentQuestionCell buildAssessmentQuestionCellForAnswer(int index, Question question) {
    return AssessmentQuestionCell(
      title: question.questionText,
      quesType: question.questionType,
      num: index,
      completed: widget.data.isSubmit,
      onSelectAnswer: (answer){
        widget.data.questions[index].answer = answer;
      }
    );
  }

  void submitForm() async {
    
    print("data");
    // print(data);

    // submitAssessments(data);
    submitAssessments(widget.data).then(
            (value) => {

          print(value.responseCode),
          if (value.responseCode == 200) {
            Navigator.pop(context),
          }
        });
  }
}

class ScreenArguments {
  final String title;
  final bool completed;

  ScreenArguments(this.title, this.completed);
}

class AssessmentArguments {
  final Response.Result result;

  AssessmentArguments(this.result);
}
