import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class CheckBoxQuestion extends StatefulWidget{
  var ques;
  var options;
  Map<String, bool> option = {
    'One' : false,
    // 'Two' : false,
    // 'Three' : false,
  };

  CheckBoxQuestion({Key key, @required this.ques, this.options});

  @override
  State<StatefulWidget> createState() =>CheckBoxQuestionState();
}

class CheckBoxQuestionState extends State<CheckBoxQuestion>{

  @override
  void initState() {
    super.initState();
    widget.option = {
      'One' : false,
      'Two' : false,
      'Three' : false,
    };
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children:[
          Text('Q. ', style: TextStyle(fontSize: 18, color: HH_Colors.accentColor, fontFamily: "ProximaNova", fontWeight: FontWeight.w500),),
          Flexible(child:Text(widget.ques??'', textAlign: TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070,  fontSize: 16))),
        ]),
        // Expanded(child:
        // Column(
        //   children: widget.option.keys.map((String key) {
        //     return new CheckboxListTile(
        //       title: new Text(key),
        //       value: widget.option[key],
        //       onChanged: (bool value) {
        //         setState(() {
        //           widget.option[key] = value;
        //         });
        //       },
        //     );
        //   }).toList(),
        // ))
      ],
    );
  }

}
