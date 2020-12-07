import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class AssessmentCell extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  final VoidCallback onClick;

  AssessmentCell({@required this.name, @required this.role, this.completed, this.onClick});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      child: Container(
      padding: EdgeInsets.fromLTRB(10, 15,10,15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    SizedBox(width: 250,child: Text(name, textAlign:TextAlign.start,overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 18,color: HH_Colors.grey_585858)))
                  ]),
                  SizedBox(width: 10,),
                  InkWell(
                    child: Container(
                      width: 70,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: HH_Colors.accentColor),
                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      child: Text(completed?'Log Now':'View', textAlign: TextAlign.center,style: TextStyle(color: HH_Colors.accentColor),),
                    ) ,
                    onTap: (){
                      onClick();
                    },)

                ],
              ) ,
              Text(completed? 'Submitted':'Pending', textAlign:TextAlign.start,style: TextStyle(fontSize:15,color: completed? HH_Colors.green_3DDB8C: HH_Colors.primaryColor),),
            ],
          ),

        ],
      ),
    ));
  }
}
