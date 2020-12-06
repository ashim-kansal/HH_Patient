import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class TharapistCell extends StatelessWidget {
  var name = "";
  var role = "";
  var showBook = false;
  final VoidCallback onClick;

  TharapistCell({@required this.name, @required this.role, this.showBook, this.onClick});


  @override
  Widget build(BuildContext context) {
    return               Container(
      padding: EdgeInsets.all(10),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/ic_avatar.png',
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Text("$name\nRole : $role", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_35444D),),
                  ]),
                  // Row(children: [
                  //   Text("john.doe@yahoo.com", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070),),
                  // ]),
                  ],
               ) ,
            ],
          ),

          showBook?InkWell(child: Container(
            // margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: HH_Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Text('Book Session', style: TextStyle(color: HH_Colors.accentColor),),
          ) ,
          onTap: (){
            onClick();
          },): Container()
        ],
      ),
    );
  }
}
