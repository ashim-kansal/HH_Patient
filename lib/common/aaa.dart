import 'package:flutter/material.dart';
import 'package:flutter_app/model/OldJournalingLisrModel.dart';
import 'package:flutter_app/utils/colors.dart';

class ExpandableListTile extends StatelessWidget{

  Result result;
  String date;

  ExpandableListTile({this.result, this.date});

  @override
  Widget build(BuildContext context) {
   return Column(

     children: _buildExpandableContent(result, date, context),
   );
  }
}

List<Widget> _buildExpandableContent(Result result,String _date, BuildContext context) {
  List<Widget> columnContent = [];

  for (Question ques in result.questions)
    columnContent.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            ques.question,
            style: TextStyle(
                color: HH_Colors.grey_585858,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Text(
            ques.answer,
            style: TextStyle(
                color: HH_Colors.grey_707070, fontSize: 16),
          ),

          SizedBox(height: 5,),
        ],
      ),
    );
  columnContent.add(SizedBox(
    height: 10,
  ));
  columnContent.add(
      Container(
        margin: EdgeInsets.only(top: 2),
        width: MediaQuery.of(context).size.width,
        child: Text(
          _date,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: HH_Colors.grey_707070,
              fontSize: 12),
        ),
      ));

  return columnContent;
}