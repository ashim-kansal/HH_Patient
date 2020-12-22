import 'package:flutter/material.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/models/AssessmentModel.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class AssessmentFormPage extends StatefulWidget {
  static const String RouteName = '/assessment_form';

  Result data;

  AssessmentFormPage({
    Key key,
    @required this.data
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssessmentFormState();
}

class AssessmentFormState extends State<AssessmentFormPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: widget.data.title,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.data.title,
              style: TextStyle(fontSize: 22, color: HH_Colors.accentColor),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.separated(
                itemCount: widget.data.questions.length,
                itemBuilder: (context, index) {
                  return AssessmentQuestionCell(
                    title: widget.data.questions[index].questionText,
                    quesType: widget.data.questions[index].questionType,
                    completed: widget.data.isSubmit,
                    onClick: () {},
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )),
            SizedBox(height: 10,),
            widget.data.isSubmit? Container() : HHButton(title: 'Submit', type: 2,isEnable: true, onClick: () {

            }),
          ],
        ));
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
