
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/agora/call_utilities.dart';
import 'package:flutter_app/agora/permissions.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/screens/drinking_diary.dart';
import 'package:flutter_app/screens/journal.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';


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

  String name = '';
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() {

    UserAPIServices().getProfile().then((value) => {
      if (value.responseCode == 200) {
        setState(() {
          name = value.result.firstName+" "+value.result.lastName;
          profileImage = value.result.profilePic;
        })
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Column(
                  children: [
                    HHHomeButton(title: AppLocalizations
                        .of(context)
                        .drinking_diary, type: 2, onClick: () {
                      Navigator.pushNamed(context, DrinkingDiaryPage.RouteName);
                    },),
                    SizedBox(height: 15),
                    HHHomeButton(title: AppLocalizations
                        .of(context)
                        .dailyjournaling, type: 2, onClick: () {
                      Navigator.pushNamed(context, JournalPage.RouteName);
                    },),
                    SizedBox(height: 15),
                    HHHomeButton(title: AppLocalizations
                        .of(context)
                        .mysession, type: 2, onClick: () {
                      Navigator.pushNamed(context, SessionPage.RouteName).then((
                          value) {
                        if (value == 'fab') {
                          print(value);
                          widget.onUpdateDashboard("fab");
                        }
                        setState(() {

                        });
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
                Text(AppLocalizations
                    .of(context)
                    .upcoming_sessions, style: TextStyle(
                    fontSize: 22, color: HH_Colors.grey_3d3d3d),),
                new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SessionPage.RouteName).then((
                        value) {
                      if (value == 'fab') {
                        print(value);
                        widget.onUpdateDashboard("fab");
                      }
                    });
                    },
                  child: Text(AppLocalizations
                      .of(context)
                      .viewall, style: TextStyle(
                    color: HH_Colors.accentColor, fontSize: 15,),),
                ),

              ],
            ),
            SizedBox(height: 15,),
            Container(
              height: 180.0,
              margin: EdgeInsets.only(bottom: 20),
              child: FutureBuilder<UpcomingSession>(
                  future: upcomingSessions(),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return HHTextView(title: AppLocalizations
                            .of(context)
                            .no_up_sessions,
                          size: 18,
                          color: HH_Colors.purpleColor,
                          textweight: FontWeight.w600,);
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (context1, index) {
                          var _date = snapshot.data.result[index].date;
                          Moment createdDt = Moment.parse('$_date');
                          return SessionCard(data: snapshot.data.result[index],
                              name: snapshot.data.result[index].programName,
                              drname: snapshot.data.result[index].therapistId
                                  .firstName + " " + snapshot.data.result[index]
                                  .therapistId.lastName,
                              sdate: createdDt.format("dd MMM, yyyy") + ' ' +
                                  snapshot.data.result[index].startTime,
                              onClick: () {
                                Navigator.pushNamed(
                                    context, SessionPage.RouteName).then((
                                    value) =>
                                    () {
                                  print('value returned ');
                                });
                              },
                              onClickVideo: () {
                                callParticipent(snapshot.data.result[index].id,
                                    snapshot.data.result[index].patientId,
                                    snapshot.data.result[index], context);
                              },
                              onClickCancel: () {
                                setState(() {

                                });
                              },onClickReschedule: () {
                                setState(() {

                                });
                              }
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20, width: 20,);
                        },
                      );
                    } else {
                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }
                  })
            )
          ,]
        )
    );
  }

  // current date and time 
  getCurrentDateTime(Result result) {

    print("dateee___ "+result.date.toString());

    var flag = false;
    var currentDate = new DateTime.now();
    
    // var d = Moment.parse(result.date.toString());
    
    // print(d.compareTo(currentDate));

    var apptDate = result.date.toString().split(" ")[0].split("-");
    
    // ignore: unrelated_type_equality_checks
    if(int.parse(apptDate[2]) == (currentDate.day) && int.parse(apptDate[1]) == currentDate.month){
      flag = true;
    }else if(currentDate.hour == (int.parse(result.startTime.split(":")[0]) + 2) || currentDate.minute >= int.parse(result.startTime.split(":")[1])){
      flag = true;
    }else if(currentDate.hour >= int.parse(result.endTime.split(":")[0]) && currentDate.minute >= int.parse(result.endTime.split(":")[1])){
      flag = true;
    }

    return flag;
  }

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }
  

  void callParticipent(
    String sessionId, String patientId, Result result, BuildContext context) async {
    
    var sessionTimeStatus = getCurrentDateTime(result);

    if(!sessionTimeStatus){
      showToast("You're now able to call before time.");
      return;
    }

    Permissions.cameraAndMicrophonePermissionsGranted().then((value) => {
          CallUtils.dial(
              from: result.patientId,
              to: result.therapistId.id,
              fromName: name,
              toName: result.therapistId.firstName+' '+result.therapistId.lastName,
              image: profileImage,
              toImage: result.therapistId.profilePic,
              context: context,
              sessionid: result.id,
              programName: result.programName,
              callDuration: result.slotDuration ,
              isVideo: true),
          FirebaseFirestore.instance
              .collection("users")
              // ignore: deprecated_member_use
              .document(result.therapistId.id)
              .snapshots()
              .forEach((element) async {
            if (element.data() != null) {
              String deviceId = element.data()["token"];

              FirebaseFirestore.instance.collection("notifications").add({
                "sendby": result.patientId,
                "message": 'VIDEO Calling',
                "deviceid": deviceId,
              });
            }
          })
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
