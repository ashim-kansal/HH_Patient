import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/ExpansionTile.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/journalWidgets.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class JournalPage extends StatefulWidget{
  static const String RouteName = '/journal';

  @override
  State<StatefulWidget> createState() =>JournalPageState();
}

class JournalPageState extends State<JournalPage>{
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Journaling', child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: HHButton(title: 'New Journal', type: 2, isEnable: isSwitched, onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              Flexible(child: HHButton(title: 'Old Journal', type: 2, isEnable: !isSwitched,onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              // HHButton(title: 'Completed Sessions', type: 2)
            ],
          ),
          Expanded(child:
          Container(
            padding: EdgeInsets.all(20),
            child: isSwitched ? getNewJournal() : getOldJournal(),
          )
          ),


        ],
      ),
    ),
    );
  }

  Widget getNewJournal(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            HHTextView(title: 'Hi! How are you feeling today ?', size: 17, color: HH_Colors.grey_707070,),
          ],
        ),
        SizedBox(height: 8,),
        HHEditText(minLines: 4,),
        SizedBox(height: 20,),
        Row(
          children: [
            HHTextView(title: 'Have you taken your medicine ?', size: 17, color: HH_Colors.grey_707070,),
          ],
        ),

        RadioGroup(),
        SizedBox(height: 10,),
        HHEditText(minLines: 4,hint: 'Add note',),
        SizedBox(height: 80,),
        HHButton(title: 'Submit', type: 2,isEnable: true,)


      ],
    );

  }

  Widget getOldJournal(){
    return ListView.separated(itemBuilder: (context, index){
      return  MyExpansionTile(title: Text('sbcd'),
        headerBackgroundColor: HH_Colors.color_9ca031,
      children: [
        Text('sbcd   1'),
        Text('sbcd   2'),
        Text('sbcd   3'),
        Text('sbcd   4'),
      ],);
    },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 5);


  }

}

