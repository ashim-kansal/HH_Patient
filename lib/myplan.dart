import 'package:flutter/material.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';

class MyPlans extends StatefulWidget {
  static const String RouteName = '/planwidget';

  var isUpdate = false;

  MyPlans({
    Key key,
    @required this.isUpdate
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => MyPlansState();
}

class MyPlansState extends State<MyPlans> {
  var pagerController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(HHString.hh, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
        ),
        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff707070), fontSize: 16),
                  ),
                ),
                Expanded(
                    child: PageView(
                      controller: pagerController,
                      children: [
                        PlanWidget(title: HHString.hh, program_type: HHString.hh, desc: HHString.desc, price: 0, onClick: (){
                          if(widget.isUpdate)
                            Navigator.pop(context);
                          else
                            Navigator.pushNamed(context, Dashboard.RouteName);

                        },),
                        PlanWidget(title: HHString.hh, program_type: HHString.hh, desc: HHString.desc, price: 1, onClick: (){}),
                        PlanWidget(title: HHString.hh, program_type: HHString.hh, desc: HHString.desc, price: 2, onClick: (){}),

                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

class MyPlansArguments {

  final bool isUpdate;

  MyPlansArguments(this.isUpdate);
}

