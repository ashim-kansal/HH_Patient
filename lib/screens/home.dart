import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/screens/journal.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';

class HomePage extends StatefulWidget {
  static const String RouteName = '/home';
  final assessments = ['abc', 'def', 'ghi' ];


  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:       Column(
      children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 40,20,40),
            child: Column(
              children: [
                HHHomeButton(title: 'Drinking Diary', type: 2),
                SizedBox(height: 15),
                HHHomeButton(title: 'Daily Journaling', type: 2, onClick: (){
                  Navigator.pushNamed(context, JournalPage.RouteName);
                },),
                SizedBox(height: 15),
                HHHomeButton(title: 'My Session', type: 2, onClick: (){
                  Navigator.pushNamed(context, SessionPage.RouteName);
                },),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Upcoming Sessions', style: TextStyle(fontSize: 22, color: HH_Colors.grey_3d3d3d),),
            Text('View All', style: TextStyle(color: HH_Colors.accentColor, fontSize: 15, ),),
          ],
        ),
        SizedBox(height: 15,),
        Container(
          height: 150.0,
          margin: EdgeInsets.only(bottom: 20),
          child:        ListView.separated(

            scrollDirection: Axis.horizontal,
            itemCount: widget.assessments.length,
            itemBuilder: (context, index) {
              return SessionCard(name: widget.assessments[index], completed: index%2 == 0, onClick: (){
                // Navigator.pushNamed(context, AssessmentFormPage.RouteName, arguments: ScreenArguments(
                //     widget.assessments[index],index%2 == 0
                // ));
              },);

            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20,width: 20,);
            },
          )
          ,
        )
      ],
    )
    );
  }
}
