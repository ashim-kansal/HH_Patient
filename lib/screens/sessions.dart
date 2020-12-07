import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';

class SessionPage extends StatefulWidget{
  static const String RouteName = '/mysessions';

  @override
  State<StatefulWidget> createState() =>SessionPageState();
}

class SessionPageState extends State<SessionPage>{
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'My Sessions', child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            child: TextField(decoration: InputDecoration(
              hintText: 'Search',
              contentPadding: EdgeInsets.all(10),

            ),),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: HHButton(title: 'Upcoming Sessions', type: 2, isEnable: isSwitched, onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              Flexible(child: HHButton(title: 'Completed Sessions', type: 2, isEnable: !isSwitched,onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              // HHButton(title: 'Completed Sessions', type: 2)
            ],
          ),
          SizedBox(height: 20,),

          Expanded(
            child: ListView.separated(itemBuilder: (context, index){
              return UpcomingSessionItem(name: 'abc', role: '', onClick: (){},);
            },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 5),
          )


          // ListView.separated(
          //   itemCount: 5,
          //   itemBuilder: (context, index) {
          //     return Container(child: Text('aa'),);
          // //     return UpcomingSessionItem(name: '', completed: index%2 == 0, onClick: (){
          // //       // Navigator.pushNamed(context, AssessmentFormPage.RouteName, arguments: ScreenArguments(
          // //       //     widget.assessments[index],index%2 == 0
          // //       // ));
          // //     },);
          // //
          //   },
          //   separatorBuilder: (context, index) {
          //     return Divider();
          //   },
          // )

        ],
      ),
    ));
  }

}
