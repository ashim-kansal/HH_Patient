import 'package:flutter/material.dart';
import 'package:flutter_app/api/DrinkingDiaryApi.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';
import 'package:flutter_app/utils/DateTimeUtils.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyGraphWidget.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class DrinkingDiaryPage extends StatefulWidget{
  static const String RouteName = '/drinking_diary';

  @override
  State<StatefulWidget> createState() => DrinkingDiaryPageState();
}
class DrinkingDiaryPageState extends State<DrinkingDiaryPage>{

  String label = '';
  Future<GetDrinkingDiaryList> dataList;

  @override
  void initState() {
    super.initState();
    dataList = getDrinkingDiaryList();
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: AppLocalizations.of(context).drinking_diary,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child:  FutureBuilder<GetDrinkingDiaryList>(
          future: dataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text(AppLocalizations.of(context).error),);
              }
              
              // SchedulerBinding.instance.addPostFrameCallback((_){
              //   setState(() {
              //     mDiaryList = snapshot.data.result;
              //   });
              // });
              List<Result> weekdayData = getWeekdaysData(snapshot.data.result);
              List<WeekSlotModal> weekSlotData = getWeeks(snapshot.data.result);

              return SingleChildScrollView(
                child: Column(
                  children: [

                    // Container(height:50, margin: EdgeInsets.only(right: 10, left: 10),
                    //     child: DrinkingDiaryDateWidget(list: snapshot.data.result, onClickItem:(position){
                    //     })),

                    SizedBox(height: 10,),
                    Container(
                          padding: EdgeInsets.all(10),
                          child: snapshot.data.result != null && snapshot.data.result.length > 0 ? MyGraphWidget(weekSlotData: weekSlotData,) : HHTextView(
                            title: "No data found.",
                            color: HH_Colors.purpleColor,
                            size: 17,
                            textweight: FontWeight.w600,
                          ),
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

  List<WeekSlotModal> getWeeks(List<Result> data){
    List<WeekSlotModal> slots = List();
    if(!data.isEmpty && data.length > 0){
      DateTime firstDate = getFirstWeekDate(data[data.length-1].date);
      DateTime lastDate = data[0].date.add(Duration(days: DateTime.daysPerWeek - data[0].date.weekday));

      int totalWeeks =(((lastDate.difference(firstDate).inDays)+1)/7).floor() ;
      print("total weeks : "+totalWeeks.toString());
      for(int i=0; i<totalWeeks; i++){
        slots.add(WeekSlotModal(id:i, weekName: "Week "+(i+1).toString(), mData: getWeekDataFromList(firstDate, data) ));
        firstDate = firstDate.add(Duration(days: 7));
      }
    }
    print(slots.toString());
    return slots;
  }
}

DateTime getFirstWeekDate(DateTime date){
  return date.subtract(Duration(days: date.weekday - 1));
}

List<Result> getWeekDataFromList(DateTime weekStartDate, List<Result> data){
  List<Result> results = List();
  data.forEach((element) {
    if(weekStartDate.isSameDate(getFirstWeekDate(element.date))){
      results.add(element);
    }
  });

  return results;

}

class WeekSlotModal{
  int id;
  String weekName;
  List<Result> mData;
  bool isSelected = false;

  WeekSlotModal({this.id, this.mData, this.weekName});

  setId(int id){
    this.id = id;
  }
  setWeekName(String weekName){
    this.weekName = weekName;
  }
  setData(List<Result> mData){
    this.mData = mData;
  }
}