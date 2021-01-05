import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/JournalingListModel.dart' as NewJournal;
import 'package:flutter_app/model/OldJournalingLisrModel.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/ExpansionTile.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/journalWidgets.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/common/aaa.dart';

class JournalPage extends StatefulWidget {
  static const String RouteName = '/journal';
  List<NewJournal.Result> result;

  @override
  State<StatefulWidget> createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {
  bool isSwitched = true;


  Future journalFuture;

  
  @override
  void initState(){
    super.initState();
    journalFuture = _getJournal();
  }

  _getJournal() async {
    return await getJournalingList();
  }

  void submitJournal (){

    print(jsonEncode(widget.result));

    for (var i = 0; i < widget.result.length; i++) {
      if(widget.result[i].answer.trim().length == 0){
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return DialogWithSingleButton(
              title: "Alert",
              content: "Please enter the answers.",
            );
          },
        );
        return;
      }

    }

    InAppAPIServices inAppAPIServices = new InAppAPIServices();

    inAppAPIServices.submitJournal(widget.result).then((value) => {
      showToast(value.responseMsg),
      if(value.responseCode == 200){
        print(value.responseCode),
        setState(() {
        isSwitched = !isSwitched;
        })
      }
    });
  }

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(
      title: 'Journaling',
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: HHButton(
                    title: 'New Journal',
                    type: 3,
                    textSize: 18,
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
                    title: 'Old Journal',
                    type: 3,
                    textSize: 18,
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
            Expanded(
                child: Container(
              child: isSwitched ? getNewJournal() : getOldJournal(),
            )),
          ],
        ),
      ),
    );
  }

  
  Widget getNewJournal() {

    return Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:  FutureBuilder(
                  future: journalFuture,
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.hasError){
                        return HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
                      }

                      SchedulerBinding.instance.addPostFrameCallback((_){

                        setState(() {
                          widget.result = snapshot.data.result;
                        });

                      });
                      return  ListView.separated(
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data.result[index].question,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  // 'Hi! How are you feeling today ?',
                                  style: TextStyle(
                                      color: HH_Colors.grey_707070,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                margin: EdgeInsets.only(left: 5),
                              ),
                              
                              SizedBox(
                                height: 5,
                              ),

                              HHEditText(
                                minLines: 4,
                                onSelectAnswer:(text){
                                  print(text);
                                  widget.result[index].answer = text;
                                },
                              ),SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }
                      );
                    }else {
                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }
                  }
                ),
                // )
              ),

            HHButton(
              title: 'Submit',
              type: 4,
              isEnable: true,
              onClick: (){
                submitJournal();
              },
            )
          ],
        )
      );
  }

  Widget getOldJournal() {
    
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<OldJournalingList>(
              future: getOldJournalingList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasError){
                      return Text("Error");
                    }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var _date = snapshot.data.result[index].createdAt;
                      Moment createdDate = Moment.parse('$_date');
                      return MyExpansionTile(
                        title: Text(''),
                        headerBackgroundColor: HH_Colors.color_9ca031,
                        leading: Text(
                          createdDate.format("dd/MM/yyyy"),
                          style: TextStyle(color: Colors.white),
                        ),
                        children: [
                          Container(
                            color: HH_Colors.color_EDEDF8,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 15, top: 15, bottom: 10, right: 10),
                            child: ExpandableListTile(result:snapshot.data.result[index], date:createdDate.format("hh:mm a"))
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snapshot.data.result.length);
                }else {
                  return Container(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                }
              },
            )
          )
        ],
      ),
    );
  }


}
