import 'package:flutter/material.dart';
import 'package:flutter_app/model/GetProgramsResponse.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';
import 'package:flutter_app/api/MyProgramsProvider.dart';

class MyPlans extends StatefulWidget {
  static const String RouteName = '/planwidget';

  var isUpdate = false;

  MyPlans({Key key, @required this.isUpdate}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyPlansState();
}

class MyPlansState extends State<MyPlans> {
  var pagerController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: HHString.hh,
        child: FutureBuilder<GetProgramsResponse>(
            future: getAllPrograms(),
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
                        style:
                            TextStyle(color: Color(0xff707070), fontSize: 16),
                      ),
                    ),
                    Expanded(
                        child: PageView.builder(
                      itemCount: snapshot.data.result.length, // Can be null
                      itemBuilder: (context, position) {
                        return PlanWidget(
                          title: snapshot.data.result[position].title,
                          program_type:
                              snapshot.data.result[position].programType,
                          desc: snapshot.data.result[position].description,
                          price: snapshot.data.result[position].amount,
                          onClick: () {
                            buyNewPlan(snapshot.data.result[position].id,snapshot.data.result[position].amount);

                              // Navigator.pushNamed(
                              //     context, QuestionairePage.RouteName);
                          },
                        );
                      },
                    )),
                  ],
                );
              } else
                return CircularProgressIndicator();
            })
    );
  }

  void buyNewPlan(String id, String amount) {

    buyPlan(id, amount).then((value) => {
      if(value.responseCode == 200){
        Navigator.pop(context),
        // if(!widget.isUpdate){
          Navigator.pushNamed(context, QuestionairePage.RouteName, arguments: QuestionaireArguments(id))
        // }

      }
    });
  }

}

class MyPlansArguments {
  final bool isUpdate;

  MyPlansArguments(this.isUpdate);
}

