import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';
import 'package:simple_moment/simple_moment.dart';

class SessionPage extends StatefulWidget {
  static const String RouteName = '/mysessions';

  @override
  State<StatefulWidget> createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {
  bool isSwitched = true;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return MyWidget(
      title: AppLocalizations.of(context).mysession,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 10,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    contentPadding: EdgeInsets.all(10),
                    counterText: ""),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: HHButton(
                    title: AppLocalizations.of(context).Upcoming,
                    textSize: 18,
                    type: 3,
                    isEnable: isSwitched,
                    onClick: () {
                      setState(() {
                        isSwitched = !isSwitched;
                      });
                    },
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: HHButton(
                    title: AppLocalizations.of(context).completed,
                    textSize: 18,
                    type: 3,
                    isEnable: !isSwitched,
                    onClick: () {
                      setState(() {
                        isSwitched = !isSwitched;
                      });
                    },
                  ),
                  flex: 1,
                ),
                // HHButton(title: 'Completed Sessions', type: 2)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: isSwitched ? getUpcomingList() : getCompleteList())
          ],
        ),
      ),
      showFloatingButton: true,
      onClickFAB: () {
        print('gg');
        Navigator.pop(context, 'fab');
      },
    );
  }

  onSearchTextChanged(String text) async {
    searchText = text;
    setState(() {});
  }

  Widget getCompleteList() {
    return FutureBuilder<UpcomingSession>(
        future: completedSessoins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return HHTextView(
                title: AppLocalizations.of(context).no_record_found,
                size: 18,
                color: HH_Colors.purpleColor,
                textweight: FontWeight.w600,
              );
            }
            List<Result> mList = snapshot.data.result;
            List<Result> searchList = List();

            if (searchText.length == 0) {
              searchList.clear();
              searchList.addAll(mList);
            } else {
              searchList.clear();
              for (Result res in mList) {
                if (res.therapistId.firstName
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) searchList.add(res);
              }
            }

            return ListView.separated(
              itemCount: searchList.length,
              itemBuilder: (context, index) {
                var _date = searchList[index].createdAt;
                Moment createdDt = Moment.parse('$_date');
                return UpcomingSessionItem(
                  name: searchList[index].programName,
                  data: searchList[index],
                  drname: searchList[index].therapistId.firstName +
                      " " +
                      searchList[index].therapistId.lastName,
                  sdate: createdDt.format("dd MMM, yyyy hh:mm a"),
                  role: '',
                  onClick: () {},
                  completed: !isSwitched,
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: isSwitched? 5: 2
            );
          } else
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }

  Widget getUpcomingList() {
    return FutureBuilder<UpcomingSession>(
        future: upcomingSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return HHTextView(
                title: AppLocalizations.of(context).no_record_found,
                size: 18,
                color: HH_Colors.purpleColor,
                textweight: FontWeight.w600,
              );
            }
            List<Result> mList = snapshot.data.result;
            List<Result> searchList = List();

            if (searchText.length == 0) {
              searchList.clear();
              searchList.addAll(mList);
            } else {
              searchList.clear();
              for (Result res in mList) {
                if (res.therapistId.firstName
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) searchList.add(res);
              }
            }

            return ListView.separated(
              itemCount: searchList.length,
              itemBuilder: (context, index) {
                var _date = searchList[index].date;
                Moment createdDt = Moment.parse('$_date');
                return UpcomingSessionItem(
                    name: searchList[index].programName,
                    data: searchList[index],
                    drname: searchList[index].therapistId.firstName +
                        " " +
                        searchList[index].therapistId.lastName,
                    sdate: createdDt.format("dd MMM, yyyy") +
                        ' ' +
                        searchList[index].startTime,
                    role: '',
                    onClick: () {},
                    completed: !isSwitched,
                    onClickCancel: () {
                      setState(() {});
                    },
                    onVideoCancel: () {
                      // if(DateTime.now().isSameDate(searchList[index].date))
                        getToken(searchList[index].id,
                            searchList[index].patientId, searchList[index]);
                      // else
                      //   showToast(context, 'Session will start soon');
                    });
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: isSwitched? 5: 2
            );
          } else
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }

  void getToken(sessionId, patientId, result) {
    String roomName = 'room_' + sessionId;
    getTwilioToken(roomName, patientId, result.therapistId.id).then((value) => {
          if (value.responseCode == '200'){
              Navigator.pushNamed(context, VideoCallPage.RouteName,
                      arguments:
                          VideoPageArgument(patientId, roomName, value.jwt))
                  .then((value) => {
                Navigator.pushNamed(context, ReviewPage.RouteName, arguments: ReviewPageArgument(result.id, result.programName))

              }),
            }
        });
  }
}
