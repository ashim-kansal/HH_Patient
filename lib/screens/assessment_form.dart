import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/Assessment_services.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/models/AssessmentModel.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class AssessmentFormPage extends StatefulWidget {
  static const String RouteName = '/assessment_form';

  Result data;

  AssessmentFormPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssessmentFormState();
}

class AssessmentFormState extends State<AssessmentFormPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: widget.data.title,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.title,
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
                itemCount: widget.data.questions.length,
                itemBuilder: (context, index) {
                  return widget.data.isSubmit
                      ? buildContainerForQuestionWithAnswer(index)
                      : buildAssessmentQuestionCellForAnswer(index);
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
                      title: 'Submit', type: 2, isEnable: true, onClick: () {
                        print(widget.data);
                        submitForm(widget.data);
              }),
            ],
          ),
        ));
  }

  Column buildContainerForQuestionWithAnswer(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.data.questions[index].questionText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 16,
                color: HH_Colors.grey_707070,
                fontFamily: "ProximaNova")),
        Text(widget.data.questions[index].answer??'hhh',
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

  AssessmentQuestionCell buildAssessmentQuestionCellForAnswer(int index) {
    return AssessmentQuestionCell(
      title: widget.data.questions[index].questionText,
      quesType: widget.data.questions[index].questionType,
      completed: widget.data.isSubmit,
      onSelectAnswer: (answer){
        widget.data.questions[index].answer = answer;
      }
    );
  }

  void submitForm(Result data) async {
    
    print("data");
    print(data);

    // submitAssessments(data);
    submitAssessments(data).then(
            (value) => {

          print(value.responseCode),
          if (value.responseCode == 200) {
            Navigator.pop(context),
            Navigator.pushNamed(context, Dashboard.RouteName)
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
  final Result result;

  AssessmentArguments(this.result);
}
