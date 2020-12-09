import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/utils/colors.dart';
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
                          child:Image.asset('assets/images/goal_2.png', 
                          )
                      ),

                      Container(
                        padding: EdgeInsets.all(40.0),
                        child: Image.asset('assets/images/goal_1.png'),
                      ),

                      Container(
                        padding: EdgeInsets.all(50.0),
                        child: Image.asset('assets/images/goal_3.png'),
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
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            
                            count == 1 ? 
                            Text(
                              "Choose your goal",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff585858), decoration: TextDecoration.none),
                            ) : count == 2 ?  Text(
                              "Video Session",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff585858), decoration: TextDecoration.none),
                            ) : Text(
                              "Daily Journaling",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff585858), decoration: TextDecoration.none),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            count == 1 ? 
                            Text(
                              "Daily drinking diary to track your progress",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Color(0xff585858), decoration: TextDecoration.none),
                            ) : count == 2 ?  Text(
                              "Join your therapist directly from your phone",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Color(0xff585858), decoration: TextDecoration.none),
                            ) : Text(
                              "To help you understand your triggers",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Color(0xff585858), decoration: TextDecoration.none),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(child: Container(
                                  height: 10,
                                  width: 25,
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                  color: count == 1 ? HH_Colors.purpleColor : HH_Colors.grey_EBEBEB,
                                  borderRadius: BorderRadius.circular(10.0)),
                                )),
                                
                                Container(
                                  height: 10,
                                  width: 25,
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                  color: count == 2 ? HH_Colors.purpleColor : HH_Colors.grey_EBEBEB,
                                  borderRadius: BorderRadius.circular(10.0)),
                                ),
                                Container(
                                  height: 10,
                                  width: 25,
                                  decoration: BoxDecoration(
                                  color: count == 3 ? HH_Colors.purpleColor : HH_Colors.grey_EBEBEB,
                                  borderRadius: BorderRadius.circular(10.0)),
                                ),
                            ]),
                             SizedBox(
                              height: 90,
                            ),
                            
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: HHButton(title: name, type: 2, isEnable: true, onClick: (){
                                  setState(() {
                                    if(count ==1){
                                      name = "Next";
                                    }else if(count ==2){
                                      name = "Done";
                                    }else{
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, LoginPage.RouteName);
                                    }
                                    count = count+1;
                                  });
                                pagerController.jumpTo(count.toDouble());


                            })
                              ,)
                             
                            )
                            
                          ],
                        ))),
              ],
            )));
  }
}

