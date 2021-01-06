import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';
import 'package:simple_moment/simple_moment.dart';

class SessionPage extends StatefulWidget{
  static const String RouteName = '/mysessions';

  @override
  State<StatefulWidget> createState() =>SessionPageState();
}

class SessionPageState extends State<SessionPage>{
  bool isSwitched = true;
  
  @override
  Widget build(BuildContext context) {
    return MyWidget(title: HHString.mysession, child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            elevation: 10,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              contentPadding: EdgeInsets.all(10),
              counterText: ""
            ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: HHButton(title: HHString.Upcoming,textSize: 18, type: 3, isEnable: isSwitched, onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              Flexible(child: HHButton(title: HHString.Completed,textSize: 18, type: 3, isEnable: !isSwitched,onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              // HHButton(title: 'Completed Sessions', type: 2)
            ],
          ),
          SizedBox(height: 20,),

          Expanded(
            child: isSwitched ? getUpcomingList() : getCompleteList()
          )


        ],
      ),
    ),
        showFloatingButton: true,
      onClickFAB: (){
      print('gg');
        Navigator.pop(context, 'fab');
      },
    );
  }

  Widget getCompleteList(){
    return FutureBuilder<UpcomingSession>(
      future: completedSessoins(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return HHTextView(title: HHString.no_record_found, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
          }
          return ListView.separated(
            itemCount: snapshot.data.result.length,
            itemBuilder: (context, index){
            var _date = snapshot.data.result[index].createdAt;
            Moment createdDt = Moment.parse('$_date');
            return UpcomingSessionItem(
              name: snapshot.data.result[index].programName, 
              data: snapshot.data.result[index],
              drname: snapshot.data.result[index].therapistId.firstName+" "+snapshot.data.result[index].therapistId.lastName,
              sdate: createdDt.format("dd MMM, yyyy hh:mm a"),
              role: '', onClick: (){}, completed: !isSwitched,);
          },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: isSwitched? 5: 2
              );
        } else
          return Container(
            child: Center(child: CircularProgressIndicator(),),
          );
      });
  }

  Widget getUpcomingList(){
    return FutureBuilder<UpcomingSession>(
        future: upcomingSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return HHTextView(title: HHString.no_record_found, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
            }
            return ListView.separated(
              itemCount: snapshot.data.result.length,
              itemBuilder: (context, index){
              var _date = snapshot.data.result[index].date;
              Moment createdDt = Moment.parse('$_date');
              return UpcomingSessionItem(
                name: snapshot.data.result[index].programName, 
                data: snapshot.data.result[index],
                drname: snapshot.data.result[index].therapistId.firstName+" "+snapshot.data.result[index].therapistId.lastName,
                sdate: createdDt.format("dd MMM, yyyy")+' '+snapshot.data.result[index].startTime,
                role: '', onClick: (){}, completed: !isSwitched,
                  onClickCancel: (){
                setState(() {

                });
              });
            },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: isSwitched? 5: 2
                );
          } else
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
        });

  }

}

