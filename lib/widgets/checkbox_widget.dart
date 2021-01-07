import 'package:flutter/material.dart';
import 'package:flutter_app/model/QuestionarieModel.dart';
import 'package:flutter_app/utils/colors.dart';

class CheckBoxQuestion extends StatefulWidget {
  var ques;
  var options;
  int num;
  final ValueChanged<List<Option>> onSelectAnswers;

  CheckBoxQuestion(
      {Key key, @required this.ques, this.options, this.num, this.onSelectAnswers});

  @override
  State<StatefulWidget> createState() => CheckBoxQuestionState();
}

class CheckBoxQuestionState extends State<CheckBoxQuestion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Text(
            widget.num??1.toString()+'. ',
            style: TextStyle(
                fontSize: 18,
                color: HH_Colors.accentColor,
                fontFamily: "ProximaNova",
                fontWeight: FontWeight.w500),
          ),
          Flexible(
              child: Text(widget.ques ?? '',
                  textAlign: TextAlign.start,
                  style:
                  TextStyle(color: HH_Colors.grey_707070, fontSize: 16))),
        ]),
        // Expanded(
             Column(
                children: _buildItem())
    // )
      ],
    );
  }

  List<Widget> _buildItem() {
    List<Widget> columnContent = [];

    List.generate(widget.options.length, (index) {
      columnContent.add(
          new CheckboxListTile(
            title: new Text(widget.options[index].option),
            value: widget.options[index].Answer=='YES',
            onChanged: (bool value) {
              setState(() {
                widget.options[index].Answer = value ? "YES" : "NO";
              });
              widget.onSelectAnswers(widget.options);
            },
          )
    );
    });

    return columnContent;
  }
}
