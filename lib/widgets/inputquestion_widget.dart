import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class InputBoxQuestion extends StatefulWidget{
  var ques;
  TextEditingController controller;

  InputBoxQuestion({Key key, @required this.ques, this.controller});

  @override
  State<StatefulWidget> createState() =>InputBoxQuestionState();
}

class InputBoxQuestionState extends State<InputBoxQuestion>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children:[
          Text('Q. ', style: TextStyle(fontSize: 18, color: HH_Colors.accentColor, fontFamily: "ProximaNova", fontWeight: FontWeight.w500),),
              Text(widget.ques, style: TextStyle(color: HH_Colors.grey_707070,  fontSize: 16)),
           ]),
        TextField(
          decoration: InputDecoration(
              // focusedErrorBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(5.0),
              //     borderSide: BorderSide(color: Color(0xffff8a73))),
              // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              // errorBorder: errorOutlineInputBorder(),
              border: normalOutlineInputBorder(),
              // suffixIcon: widget.showeye == true
              //     ? const Icon(
              //   Icons.remove_red_eye,
              //   size: 20,
              //   color: Color(0xffCBCBCB),
              // )
              //     : null
        ),

        )
      ],
    );
  }

}
