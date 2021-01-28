import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/MyProgramsProvider.dart';
import 'package:flutter_app/model/MyPlanResponse.dart';
import 'package:flutter_app/myplan.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class CurrentPlansPage extends StatefulWidget {
  static const String RouteName = '/current_plan';

  @override
  State<StatefulWidget> createState() => CurrentPlansPageState();
}

class CurrentPlansPageState extends State<CurrentPlansPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(
      title: AppLocalizations.of(context).hh,
      child: FutureBuilder<MyPlanResponse>(
          future: getMyPrograms(),
          builder: (context, snapshot) {
            //  print("errror in $snapshot");
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(AppLocalizations.of(context).error),
                );
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff707070), fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                                      snapshot.data.result.programSubscription
                                          .title,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(8, 8),
                                    ),
                                    Text(
                                      snapshot.data.result.programSubscription
                                          .programType,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(8, 8),
                                    ),
                                    Text(
                                      '\$' +
                                          snapshot.data.result
                                              .programSubscription.amount.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 44),
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(8, 8),
                                    ),

                                    // snapshot.data.result.programSubscription
                                    //         .description
                                    //         .contains("div")
                                        Html(
                                            data: snapshot
                                                .data
                                                .result
                                                .programSubscription
                                                .description,
                                            // style: {
                                            //   "div": Style(
                                            //       color: HH_Colors.color_707070,
                                            //       fontSize: FontSize(15.0)),
                                            //   "p": Style(
                                            //       color: HH_Colors.color_707070,
                                            //       fontSize: FontSize(15.0))
                                            // },
                                            // style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
                                          )
                                        // : Text(
                                        //     snapshot
                                        //         .data
                                        //         .result
                                        //         .programSubscription
                                        //         .description,
                                        //     textAlign: TextAlign.start,
                                        //     style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: 16),
                                        //   ),
                                    // new Expanded(
                                    //   flex: 1,
                                    //   child: new SingleChildScrollView(
                                    //       scrollDirection: Axis.vertical,
                                    //   child:                                ,
                                    //       )),
                                    ,SizedBox.fromSize(
                                      size: Size(8, 20),
                                    ),
                                    Container(
                                        child: Text(
                                          'Free',
                                          style: TextStyle(
                                              color: HH_Colors.grey_585858),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(70, 20, 70, 20),
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
                    ),
                  ),
                  HHButton(
                    title: AppLocalizations.of(context).UpgradeNow,
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
              return Center(child: CircularProgressIndicator());
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
      title: AppLocalizations.of(context).hh,
      child: FutureBuilder<MyPlanResponse>(
          future: getMyPrograms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(AppLocalizations.of(context).error),
                );
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff707070), fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                                      snapshot.data.result.programSubscription
                                          .title,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(8, 8),
                                    ),
                                    Text(
                                      snapshot.data.result.programSubscription
                                          .programType,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(8, 8),
                                    ),
                                    Text(
                                      '\$' +
                                      snapshot.data.result.programSubscription.amount.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 44),
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(8, 8),
                                    ),
                                    // snapshot.data.result.programSubscription
                                    //         .description
                                    //         .contains("div")
                                    //     ?
                                    Html(
                                        data: snapshot
                                            .data
                                            .result
                                            .programSubscription
                                            .description,
                                        // style: {
                                            //   "div": Style(
                                            //       color: HH_Colors.color_707070,
                                            //       fontSize: FontSize(15.0)),
                                            //   "p": Style(
                                            //       color: HH_Colors.color_707070,
                                            //       fontSize: FontSize(15.0))
                                            // },
                                            // style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
                                      )
                                        // : Text(
                                        //     snapshot
                                        //         .data
                                        //         .result
                                        //         .programSubscription
                                        //         .description,
                                        //     textAlign: TextAlign.start,
                                        //     style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: 16),
                                        //   ),
                                    // new Expanded(
                                    //   flex: 1,
                                    //   child: new SingleChildScrollView(
                                    //       scrollDirection: Axis.vertical,
                                    //   child:                                ,
                                    //       )),
                                    ,SizedBox.fromSize(
                                      size: Size(8, 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                  HHButton(
                    title: AppLocalizations.of(context).cancel,
                    type: 1,
                    isEnable: true,
                    onClick: () {
                      cancelProgram();
                    },
                  )
                ],
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  void cancelProgram() {
    cancelPrograms().then((value) => {
          if (value.responseCode == 200)
            {
              Navigator.pop(context),
              Navigator.pushNamed(context, MyPlans.RouteName,
                  arguments: MyPlansArguments(true))
            }
        });
  }
}
