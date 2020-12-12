import 'package:flutter/material.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';

class CurrentPlansPage extends StatefulWidget{
  static const String RouteName = '/current_plan';

  @override
  State<StatefulWidget> createState() => CurrentPlansPageState();

}

class CurrentPlansPageState extends State<CurrentPlansPage>{

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Heal@heal', child:
    Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,

        padding: EdgeInsets.all(15),

        children: [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff707070), fontSize: 16),
          ),
          SizedBox(height: 10),
          Container(padding: EdgeInsets.only(left: 10),alignment: Alignment.topCenter,
              child: PlanWidget(title: HHString.hh, program_type: HHString.hh, desc: HHString.desc, price: 0, onClick: (){},),
          ),
          SizedBox(height: 10),
          HHButton(title: 'Upgrade Now', type: 1, isEnable: true,onClick: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, MyPlans.RouteName, arguments: MyPlansArguments(true));
          },)

        ],
      ),
    )
    );
  }
}



class CancelPlansPage extends StatefulWidget{
  static const String RouteName = '/Cancel_plan';

  @override
  State<StatefulWidget> createState() => CancelPlansPageState();

}

class CancelPlansPageState extends State<CancelPlansPage>{

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Heal@heal', child:
    Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,

        padding: EdgeInsets.all(15),

        children: [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff707070), fontSize: 16),
          ),
          SizedBox(height: 20),
          Container(
            // height: MediaQuery.of(context).size.height,
            child: new Stack(

              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  child: PlanWidget(
                    title: HHString.hh,
                    program_type: HHString.hh,
                    desc: HHString.desc,
                    price: 0,
                    enable: false,
                    onClick: () {},
                  ),
                ),
                new Align(
                  alignment: Alignment.bottomCenter,
                  child: HHButton(
                    title: 'Cancel',
                    type: 1,
                    isEnable: true,
                    onClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MyPlans.RouteName,
                          arguments: MyPlansArguments(true));
                    },
                  ),
                )
              ],
            ),
          ),


          SizedBox(height: 10),


        ],
      ),
    )
    );
  }
}