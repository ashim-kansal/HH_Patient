import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/utils/colors.dart';

class TharapistCell extends StatelessWidget {
  var name = "";
  String image = "";
  var role = "";
  var showBook = false;
  final VoidCallback onClick;

  TharapistCell({@required this.name, @required this.role, this.image, this.showBook, this.onClick});


  @override
  Widget build(BuildContext context) {
    return               Container(
      padding: EdgeInsets.all(5),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              image == ""?
              Image.asset(
                'assets/images/ic_avatar.png',
                height: 18,
                width: 18,
              ) : CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 25,
              )
              ,
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text("$name", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_35444D),),
                  ]),
                  Row(children: [
                    Text("Role : "+role.replaceAll("_", " ")??"", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070),),
                  ]),
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
            child: Text(AppLocalizations.of(context).bookSession, style: TextStyle(color: HH_Colors.accentColor),),
          ) ,
          onTap: (){
            onClick();
          },): Container()
        ],
      ),
    );
  }
}

class ChatUserCell extends StatelessWidget {
  var name = "";
  var online = false;
  var message = "";
  var profile = "";
  var time = "";
  final VoidCallback onClick;

  ChatUserCell({@required this.name, @required this.online, this.onClick, this.message,this.profile, this.time});


  @override
  Widget build(BuildContext context) {
    return
        InkWell(
          onTap: (){
            onClick();
          },
          child:       Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: HH_Colors.color_D9D9D9),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: HH_Colors.color_F2EEEE,
            ),
            padding: EdgeInsets.all(10),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                     ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        profile,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    // Image.asset(
                    //   'assets/images/ic_avatar.png',
                    //   height: 50,
                    //   width: 50,
                    // ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(name, textAlign:TextAlign.start,style: TextStyle(fontSize:20,color: HH_Colors.grey_585858),),
                        ]),
                        Row(children: [
                          Text(message, textAlign:TextAlign.start,style: TextStyle(fontSize:15, color: HH_Colors.grey_707070),),
                        ]),
                      ],
                    ) ,
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(time,textAlign: TextAlign.start ,style: TextStyle(color: HH_Colors.accentColor, fontSize: 15),)
                  ],
                )
              ],
            ),
          ),
        );
  }
}

