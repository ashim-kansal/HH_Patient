import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/model/NotificationListRepsonse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/message.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

class NotificationPage extends StatefulWidget {
  static const String RouteName = '/notification';

  NotificationPage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MyWidget( title: AppLocalizations.of(context).Notifications,
        child:FutureBuilder<NotificationListRepsonse>(
            future: getNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(AppLocalizations.of(context).not_data_found),);
                }

                if(snapshot.data.result.length == 0){
                  return Center(child: Text(AppLocalizations.of(context).no_record_found),);
                }

                // setState(() {
                //   widget.therapists = snapshot.data.result;
                // });

                return ListView.separated(
                  itemCount: snapshot.data.result.length,
                  itemBuilder: (context, index) {
                    var _date = snapshot.data.result[index].createdAt;
                    Moment createdDt = Moment.parse('$_date');
                    return NotificationList(
                      title: snapshot.data.result[index].body,
                      subtitle: createdDt.format("dd MMM, yyyy"),
                      id: snapshot.data.result[index].id,
                      onDeleteClick: (){
                          deleteNotification(snapshot.data.result[index].id).then((value) => {
                            if(value.responseCode == 200){
                              setState((){

                              })
                            }
                          });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: HH_Colors.accentColor,);
                  },
                );
              } else
                return Container(
                  child: Center(child: CircularProgressIndicator(),),
                );
            })

    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}