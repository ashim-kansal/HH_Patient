import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widgets/linechart.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/schedule_widgets.dart';
import 'package:flutter_app/api/DrinkingDiaryApi.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/utils/DateTimeUtils.dart';
import 'package:simple_moment/simple_moment.dart';

class DrinkingDiaryPage extends StatefulWidget{
  static const String RouteName = '/drinking_diary';

  @override
  State<StatefulWidget> createState() => DrinkingDiaryPageState();
}
class DrinkingDiaryPageState extends State<DrinkingDiaryPage>{

  String label = '';
  List<Result> mDiaryList;
  Future<GetDrinkingDiaryList> dataList;
  int pos = 0;
  List<Result> graphData;

  @override
  void initState() {
    super.initState();
    dataList = getDrinkingDiaryList();
    pos??0;
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Drinking Diary',
        child: Container(
          height: MediaQuery.of(context).size.height,
          child:      FutureBuilder<GetDrinkingDiaryList>(
          future: dataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text(AppLocalizations.of(context).error),);
              }

              SchedulerBinding.instance.addPostFrameCallback((_){
                setState(() {
                  mDiaryList = snapshot.data.result;
                });
              });
              List<Result> weekdayData = getWeekdaysData(snapshot.data.result);
              graphData = getGraphData(snapshot.data.result, pos);
              label = getLabel(graphData);


              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: HH_Colors.primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
                      ),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10,),
                          // Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                          Text(label, style: TextStyle(color: Colors.white),),
                          // Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    Container(height:50, margin: EdgeInsets.only(right: 10, left: 10),
                        child: DrinkingDiaryDateWidget(list: snapshot.data.result, onClickItem:(position){
                          setState(() {
                            pos = position;
                          });
                        })),

                    SizedBox(height: 10,),
                    Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child:             Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height/3,
                          child: SimpleLineChart.withData(graphData),
                        )

                    ),
                    SizedBox(height: 20,),
                    DrinkingDiaryCell(day:'Mon', data: weekdayData[0]??Result(), onClickGoal: (){
                      onClickAddGoal();
                    },),
                    DrinkingDiaryCell(day:'Tue', data: weekdayData[1]??Result(), onClickGoal: (){
                      onClickAddGoal();
                    },),
                    DrinkingDiaryCell(day:'Wed', data: weekdayData[2]??Result(), onClickGoal: (){
                      onClickAddGoal();
                    },),
                    DrinkingDiaryCell(day:'Thu', data: weekdayData[3]??Result(), onClickGoal: (){
                      print('onnn');
                      onClickAddGoal();
                    },),
                    DrinkingDiaryCell(day:'Fri', data: weekdayData[4]??Result(), onClickGoal: (){
                      onClickAddGoal();
                    },),
                    DrinkingDiaryCell(day:'Sat', data: weekdayData[5]??Result(), onClickGoal: (){
                      onClickAddGoal();
                    },),
                    DrinkingDiaryCell(day:'Sun', data: weekdayData[6]??Result(), onClickGoal: (){
                      onClickAddGoal();
                    },),


                  ],
                ),
              );

            } else{
              return Container(
                child: Center(child: CircularProgressIndicator(),),
              );
            }


          }),
        )
    );
  }

  getDayData(int dayName, List<Result> list){
    var now = new DateTime.now();

    while(now.weekday!=dayName)
    {
      now=now.subtract(new Duration(days: 1));
    }


    for(int i=0; i<7;i++){
      if(list.length > i && list[i].date.isSameDate(now)){
          return list[i];
      }
    }
    return null;

  }

  onClickAddGoal(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return DialogWithField(
          count: (val){
            print('hjjjj'+pos.toString());
            updateGoal(val);
          },
          onClick: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void updateGoal(int val) {
    updateDrinkingGoal(val).then((value) => {
      if(value.responseCode == 200){
        showToast(context, value.responseMessage),
        setState((){
          dataList = getDrinkingDiaryList();
        })
      }
    });
  }

  List<Result> getWeekdaysData(List<Result> list) {
    List<Result> mList = new List();
    for(int i=1; i<=7; i++){
        mList.add(getDayData(i, list)??Result());
    }
    return mList;
  }

  List<Result> getGraphData(List<Result> result, int pos) {
    List<Result> mList = new List();
    if(result.length > pos){
      if(result.length > pos+7){
        mList.addAll(result.getRange(pos, pos+7));
      }else{
        mList.addAll(result.getRange(pos, result.length-1));
      }
    }
    return mList;
  }

  String getLabel(List<Result> graphData) {
    if(graphData.length > 0) {
      String start = getDateLabel(graphData[0].date);
      String end = getDateLabel(graphData[graphData.length - 1].date);
      return end+" to "+start;
    }

    return  '';
  }
  String getDateLabel(mdate){
    Moment date = Moment.parse(mdate.toString());
    return date.format("dd MMM");

  }
}