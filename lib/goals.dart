import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/widgets/mywidgets.dart';


class MyGoals extends StatefulWidget {
  static const String RouteName = '/goals';

  @override
  State<StatefulWidget> createState() => MyGoalsState();
}

class MyGoalsState extends State<MyGoals> {
  String dropdownValue = 'English';
  String name = 'Get Started';
  var count = 1;
  var pagerController = PageController(
    initialPage: 1,
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            color: Color(0xfff2eeee),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: PageView(
                    controller: pagerController,
                    children: [
                      Container(
                        padding: EdgeInsets.all(30.0),
                        child: FlutterLogo(textColor: Colors.amber,),
                      ),

                      Container(
                        padding: EdgeInsets.all(40.0),
                        child: FlutterLogo(textColor: Colors.blue,),
                      ),

                      Container(
                        padding: EdgeInsets.all(50.0),
                        child: FlutterLogo(textColor: Colors.black,),
                      )
                    ],
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80.0),
                          ),
                          color: Colors.white,
                        ),

                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [

                            HHButton(title: name, type: 2, onClick: (){
                              setState(() {
                                if(count ==1){
                                  name = "Next";
                                }else if(count ==2){
                                  name = "Done";
                                }else{
                                  Navigator.pushNamed(context, LoginPage.RouteName);
                                }
                                count = count+1;
                              });
                              pagerController.jumpTo(count.toDouble());
                            })
                          ],
                        ))),
              ],
            )));
  }
}
