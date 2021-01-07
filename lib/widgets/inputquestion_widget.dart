import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class InputBoxQuestion extends StatefulWidget{
  var ques;
  var num;
  var controller = TextEditingController();
  final ValueChanged<String> onSelectAnswer;

  InputBoxQuestion({Key key, @required this.ques, this.onSelectAnswer, this.num});

  @override
  State<StatefulWidget> createState() =>InputBoxQuestionState();
}

class InputBoxQuestionState extends State<InputBoxQuestion>{

  @override
  void initState() {
    widget.controller = TextEditingController();
    widget.controller.addListener((){
      widget.onSelectAnswer(widget.controller.text);
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children:[
          Text(
            widget.num??1.toString()+'. ',
            style: TextStyle(fontSize: 18, color: HH_Colors.accentColor, fontFamily: "ProximaNova", fontWeight: FontWeight.w500),),
          Flexible(child:Text(widget.ques, textAlign: TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070,  fontSize: 16))),
        ]),
        SizedBox(height: 10,),
        HHEditText(onSelectAnswer:(text){
          widget.onSelectAnswer(text);
        }),
        SizedBox(height: 10,),
      ],
    );
  }

}
