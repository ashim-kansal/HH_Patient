import 'package:callkeep/callkeep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/callkit.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/drinking_diary.dart';
import 'package:flutter_app/screens/journal.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';
import 'package:simple_moment/simple_moment.dart';

class HomePage extends StatefulWidget {
  static const String RouteName = '/home';
  final assessments = ['abc', 'def', 'ghi' ];
  final ValueChanged<String> onUpdateDashboard;

  VoidCallback showTherapist;
  HomePage({this.onUpdateDashboard});


  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:       Column(
      children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 40,20,40),
            child: Column(
              children: [
                HHHomeButton(title: AppLocalizations.of(context).drinking_diary, type: 2, onClick: (){
                  Navigator.pushNamed(context, DrinkingDiaryPage.RouteName);
                },),
                SizedBox(height: 15),
                HHHomeButton(title: AppLocalizations.of(context).dailyjournaling, type: 2, onClick: (){
                  Navigator.pushNamed(context, JournalPage.RouteName);
                },),
                SizedBox(height: 15),
                HHHomeButton(title: AppLocalizations.of(context).mysession, type: 2, onClick: (){
                  Navigator.pushNamed(context, SessionPage.RouteName).then((value){
                    if(value == 'fab' ) {
                      print(value);
                      widget.onUpdateDashboard("fab");
                    }
                  });
                },),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).upcoming_sessions, style: TextStyle(fontSize: 22, color: HH_Colors.grey_3d3d3d),),
            new GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SessionPage.RouteName);
              },
              child: Text(AppLocalizations.of(context).viewall, style: TextStyle(color: HH_Colors.accentColor, fontSize: 15, ), ),
            ),
            
            ],
        ),
        SizedBox(height: 15,),
        Container(
          height: 170.0,
          margin: EdgeInsets.only(bottom: 20),
          child: FutureBuilder<UpcomingSession>(
            future: upcomingSessions(),
            builder: (builder, snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasError){
                return HHTextView(title: AppLocalizations.of(context).no_up_sessions, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.result.length,
                itemBuilder: (context, index) {
                  var _date = snapshot.data.result[index].date;
                  Moment createdDt = Moment.parse('$_date');
                  return SessionCard(data: snapshot.data.result[index],name: snapshot.data.result[index].programName,
                    drname: snapshot.data.result[index].therapistId.firstName+" "+snapshot.data.result[index].therapistId.lastName,
                    sdate: createdDt.format("dd MMM, yyyy")+' '+snapshot.data.result[index].startTime,
                    onClick: (){
                      Navigator.pushNamed(context, SessionPage.RouteName).then((value) => (){
                        print('value returned ');
                      });
                    },
                      onClickVideo: (){
                        final FlutterCallkeep _callKeep = FlutterCallkeep();

                        getToken(snapshot.data.result[index].id, snapshot.data.result[index].patientId,snapshot.data.result[index]);
                      },
                    onClickCancel: (){
                      setState(() {

                      });
                    }
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20,width: 20,);
                },
              );
            }else {
              return Container(
                child: Center(child: CircularProgressIndicator(),),
              );
            }
          })
          // ListView.separated(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: widget.assessments.length,
          //   itemBuilder: (context, index) {
          //     return SessionCard(name: widget.assessments[index], completed: index%2 == 0, onClick: (){
          //       Navigator.pushNamed(context, SessionPage.RouteName);
          //     },);

          //   },
          //   separatorBuilder: (context, index) {
          //     return SizedBox(height: 20,width: 20,);
          //   },
          // )
          ,
        )
      ],
    )
    );
  }

  void getToken(sessionId, patientId, Result result ) {
    String roomName = 'room_'+sessionId;
      getTwilioToken(roomName, patientId, result.therapistId.id, result.programName).then(
              (value) => {
                if (value.responseCode == '200') {

    Navigator.pushNamed(context, VideoCallPage.RouteName, arguments: VideoPageArgument(patientId, roomName, value.jwt))
                    .then((value) => {
                      Navigator.pushNamed(context, ReviewPage.RouteName, arguments: ReviewPageArgument(result.id, result.programName))
                }),
            }
          });


  }


}

class VideoPageArgument{

  String token;
  String roomName;
  String identity;

  VideoPageArgument(this.identity, this.roomName, this.token);
}

class ReviewPageArgument{

  String id;
  String name;
  ReviewPageArgument(this.id, this.name);
}
