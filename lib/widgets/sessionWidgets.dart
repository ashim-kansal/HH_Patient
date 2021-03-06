import 'package:flutter/material.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/ReScheduleSession.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/review.dart';
// import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/popup_window.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';

class SessionCard extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  var drname = "";
  var sdate = "";
  final VoidCallback onClick;
  final VoidCallback onClickCancel;
  final VoidCallback onClickVideo;
  Result data;

  SessionCard(
      {@required this.name,@required this.data, @required this.role, this.completed, this.onClick, this.onClickVideo, this.onClickCancel, this.drname, this.sdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*(2/3),
        child: Card(
            color: HH_Colors.color_F2EEEE,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: InkWell(
          onTap: (){
            onClick();
          },
          child:  Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(sdate, style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070),),
                SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.therapistId.profilePic == ""?
                    Image.asset(
                      'assets/images/ic_avatar.png',
                      height: 18,
                      width: 18,
                    ) : CircleAvatar(
                      backgroundImage: NetworkImage(data.therapistId.profilePic),
                      radius: 18,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.therapistId.role.toLowerCase() == "physician" ? 'Dr. '+drname : drname,textAlign:TextAlign.start,style: TextStyle(fontSize: 18, color: HH_Colors.grey_585858, fontWeight: FontWeight.w600)),
                        Text(data.therapistId.role.replaceAll("_", " ")??"" ,textAlign:TextAlign.start,style: TextStyle(fontSize: 14, color: HH_Colors.grey_707070)),
                        Text("Duration: "+data.slotDuration.toString()+' mins' ,textAlign:TextAlign.start,style: TextStyle(fontSize: 10, color: HH_Colors.grey_707070)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ButtonTheme(
                              height: 40,
                              minWidth: 40,
                              child: FlatButton(
                                color: Colors.white,
                                child: Icon(Icons.chat
                                  , color: HH_Colors.accentColor, size: 20,),
                                onPressed: (){
                                  print('receiverId  : '+data.therapistId.id);
                                  Navigator.pushNamed(context, ChatPage.RouteName, arguments: ChatArguments(data.therapistId.id));
                                },
                                shape: CircleBorder(                            side: BorderSide(color: HH_Colors.color_EEDDDD, width: 1)),
                              ),
                            ),
                            ButtonTheme(
                                height: 40,
                                minWidth: 40,
                                child: FlatButton(
                                  color: Colors.white,
                                  child: Icon(Icons.video_call, color: HH_Colors.primaryColor,size: 20,),
                                  onPressed: (){
                                    onClickVideo();
                                  },
                                  shape: CircleBorder( 
                                    side: BorderSide(color: HH_Colors.color_EEDDDD, width: 1)),
                                )),

                          ],
                        )

                      ],
                    )
                  ],
                ),

              ],
            ),
                Column(
                  children: [
                    HHOptionButton(onClickCancel: (){
                      showDialog(context: context,
                        builder: (BuildContext dialogContext) {
                          return CancelDialog(
                              onYesPress: ()async {
                                cancelSession(data.id).then(
                                        (value) => {

                                      print(value.responseCode),
                                      if (value.responseCode == 200) {
                                        Navigator.pop(context),
                                        showToast(context, value.responseMessage),

                                        onClickCancel()
                                        // Navigator.pushNamed(context, Dashboard.RouteName)
                                      }
                                    });
                                // Navigator.pushNamed(context, SelectLanguage.RouteName);
                              },
                              onDenyPress: (){
                                Navigator.pop(context);
                              }
                          );
                        },
                      );
                    }, onClickReSchedule: (){
                      Navigator.pushNamed(context, ReScheduleSessionPage.RouteName, arguments: data);
                    },),],
                ),
              ],
            )
          ),
        )
        ));
  }




}

class AssessmentQuestionCell extends StatelessWidget {
  var title = "";
  int quesType;
  var completed = false;
  final VoidCallback onClick;

  AssessmentQuestionCell({@required this.title,
    @required this.quesType,
    this.completed,
    this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style:
              TextStyle(fontSize: 16, color: HH_Colors.grey_707070)),
          quesType == 0 ? getInputQuest() : quesType == 1
              ? getSingleChoiceQuest()
              : getMultiChoiceQuest(),
        ],
      ),
    );
  }

  Widget getInputQuest() {
    return Container();
  }

  Widget getSingleChoiceQuest() {
    return MySingleChoiceQuesWidget();
  }

  Widget getMultiChoiceQuest() {
    return Container();
  }
}

class MySingleChoiceQuesWidget extends StatefulWidget {

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MySingleChoiceQuesWidget> {
  var options= ['Yes', 'No'];

  Widget build(BuildContext context) {
    String _site = options[0];

    return Row(
      children: getOptions(options, _site),
    );
  }

  getOptions(options, _site) {
    final children = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      children.add(getRadioOption(options[i], _site, (){}));
    }
    return children;
  }
  Widget getRadioOption(String title, String _site, String Function() param2){
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: _site,
          onChanged: (String value) {

          },
          activeColor: HH_Colors.grey_707070,
        ),
        Text(title, style: TextStyle(fontSize: 16,color: HH_Colors.grey_707070),),

      ],
    );
  }

}

class UpcomingSessionItem extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  var drname = "";
  var sdate = "";
  Result data;
  final VoidCallback onClick;
  final VoidCallback onClickCancel;
  final VoidCallback onVideoCancel;


  UpcomingSessionItem(
      {@required this.name,@required this.data, @required this.role, this.completed, this.onVideoCancel, this.onClick, this.drname, this.sdate, this.onClickCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 10, 10, 10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      data.therapistId.profilePic == ""?
                      Image.asset(
                        'assets/images/ic_avatar.png',
                        height: 18,
                        width: 18,
                      ) : CircleAvatar(
                        backgroundImage: NetworkImage(data.therapistId.profilePic),
                        radius: 18,
                        // Image.network(profileImage,
                        // height: 50,
                        // width: 50,),
                      ),

                      SizedBox(width: 10,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              'Dr. '+drname,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: HH_Colors.grey_585858,
                                fontWeight: FontWeight.w600
                              ),
                            )

                          ]),
                          Row(children: [
                            Text(sdate, textAlign:TextAlign.start,style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),),
                          ]),
                          Row(children: [
                            Text('Duration: '+data.slotDuration.toString()+' mins', textAlign:TextAlign.start,style: TextStyle(fontSize: 12, color: HH_Colors.grey_707070),),
                          ]),
                        ],
                      )
                    ],
                  ),

                  completed?
                      Row(
                        children: [
                          Icon(Icons.check_box, color: HH_Colors.color_17AB35,),
                          Text(AppLocalizations.of(context).completed, style: TextStyle(color: HH_Colors.color_17AB35),)

                        ],
                      )
                      :
                  Row(
                    children: [
                      ButtonTheme(
                        height: 35,
                        minWidth: 35,
                        child: FlatButton(
                          color: Colors.white,
                          child: Icon(Icons.chat, color: HH_Colors.accentColor, size: 18,),
                          onPressed: (){
                            Navigator.pushNamed(context, ChatPage.RouteName, arguments: ChatArguments(data.therapistId.id));
                          },
                          shape: CircleBorder( side: BorderSide(color: HH_Colors.color_EEDDDD, width: 1)),

                        ),
                      ),

                      ButtonTheme(
                          height: 35,
                          minWidth: 35,
                          child: FlatButton(

                              color: Colors.white,
                              child: Icon(Icons.video_call, color: HH_Colors.primaryColor,size: 18,),
                              onPressed: (){
                                // Navigator.pushNamed(context, ReviewPage.RouteName);
                                onVideoCancel();
                              },
                            shape: CircleBorder( side: BorderSide(color: HH_Colors.color_EEDDDD, width: 1)),
                          )),
                      HHOptionButton(onClickCancel: (){
                        showDialog(context: context,
                          builder: (BuildContext dialogContext) {
                            return CancelDialog(
                                onYesPress: ()async {
                                  cancelSession(data.id).then(
                                          (value) => {

                                        print(value.responseCode),
                                        if (value.responseCode == 200) {
                                          Navigator.pop(context),
                                          showToast(context, value.responseMessage),
                                          onClickCancel()
                                          // Navigator.pushNamed(context, Dashboard.RouteName)
                                        }
                                      });
                                  // Navigator.pushNamed(context, SelectLanguage.RouteName);
                                },
                                onDenyPress: (){
                                  Navigator.pop(context);
                                }
                            );
                          },
                        );
                      }, onClickReSchedule: (){
                        Navigator.pushNamed(context, ReScheduleSessionPage.RouteName, arguments: data);
                      },)
                    ],
                  )
                ],

              ),
            )
          )
        );
  }
}
