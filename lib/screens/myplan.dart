import 'package:flutter/material.dart';
import 'package:flutter_app/api/MyProgramsProvider.dart';
import 'package:flutter_app/model/MyPlanResponse.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';

class CurrentPlansPage extends StatefulWidget {
  static const String RouteName = '/current_plan';

  @override
  State<StatefulWidget> createState() => CurrentPlansPageState();
}

class CurrentPlansPageState extends State<CurrentPlansPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(
      title: 'Heal@heal',
      child: FutureBuilder<MyPlanResponse>(
          future: getMyPrograms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error");
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff707070), fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Theme.of(context).accentColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.result.programSubscription.title,
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                                ),
                                SizedBox.fromSize(
                                  size: Size(8, 8),
                                ),
                                Text(
                                  snapshot.data.result.programSubscription.programType,
                                  textAlign: TextAlign.start,
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                                ),
                                SizedBox.fromSize(
                                  size: Size(8, 8),
                                ),
                                Text(
                                  '\$'+snapshot.data.result.programSubscription.amount,
                                  textAlign: TextAlign.start,
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 44),
                                ),
                                SizedBox.fromSize(
                                  size: Size(8, 8),
                                ),
                                Text(
                                  snapshot.data.result.programSubscription.description,
                                  textAlign: TextAlign.start,
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox.fromSize(
                                  size: Size(8, 20),
                                ),
                                Container(
                                    child: Text(
                                      'Free',
                                      style:
                                      TextStyle(color: HH_Colors.grey_585858),
                                    ),
                                    padding: EdgeInsets.fromLTRB(70, 20, 70, 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        new BorderRadius.circular(10.0),
                                        color: Colors.white)),
                                SizedBox.fromSize(
                                  size: Size(8, 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 10),
                  HHButton(
                    title: 'Upgrade Now',
                    type: 1,
                    isEnable: true,
                    onClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MyPlans.RouteName,
                          arguments: MyPlansArguments(true));
                    },
                  )
                ],
              );
            } else
              return CircularProgressIndicator();
          }),

    );
  }
}

class CancelPlansPage extends StatefulWidget {
  static const String RouteName = '/Cancel_plan';

  @override
  State<StatefulWidget> createState() => CancelPlansPageState();
}

class CancelPlansPageState extends State<CancelPlansPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: 'Heal@heal',
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff707070), fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HHString.hh,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox.fromSize(
                        size: Size(8, 8),
                      ),
                      Text(
                        HHString.hh,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox.fromSize(
                        size: Size(8, 8),
                      ),
                      Text(
                        '\$0',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 44),
                      ),
                      SizedBox.fromSize(
                        size: Size(8, 8),
                      ),
                      Text(
                        HHString.desc,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox.fromSize(
                        size: Size(8, 20),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
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
        ));
  }
}
