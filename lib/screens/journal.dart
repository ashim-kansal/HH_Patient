import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/JournalingListModel.dart';
import 'package:flutter_app/model/OldJournalingLisrModel.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/ExpansionTile.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/journalWidgets.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';

class JournalPage extends StatefulWidget {
  static const String RouteName = '/journal';

  @override
  State<StatefulWidget> createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {
  bool isSwitched = true;

  var items = [];

  // ignore: deprecated_member_use
  List<TextEditingController> _controllers = new List();

  List<String> litems = [];

  void submitJournal (){

    var params = [];
    int totalItems = litems.length;

    for (var i = 0; i < totalItems; i++) {

      if(_controllers[i].text.trim().length == 0){
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

      var obj = {
        "question": litems[i],
        "answer": _controllers[i].text
      };
      params.add(obj);
    }

    print(params);

    InAppAPIServices inAppAPIServices = new InAppAPIServices();

    inAppAPIServices.submitJournal(params).then((value) => {
      params = [],
      showToast(value.responseMsg),
      if(value.responseCode == 200){
        for (var i = 0; i < totalItems; i++) {
          _controllers[i].clear()
        }
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
              child: 
                FutureBuilder<JournalingList>(
                  future: getJournalingList(),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.hasError){
                        return HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
                      }
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (context, index) {
                           _controllers.add(new TextEditingController());
                          litems.add(snapshot.data.result[index].question);
                          return Column(
                            children: [
                              // Row(
                              //   children: [
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
                              //   ],
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              HHEditText(
                                minLines: 4,
                                controller: _controllers[index],
                                // onSubmitText: () {
                                //   print("done");
                                //   var text =  _controllers[index].text;
                                //   litems.add({
                                //     "question":snapshot.data.result[index].question,
                                //     "answer": text
                                //   });
                                // },
                                // onChange: (text) async {
                                //   print(text);
                                // }
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
        ));
  }

  Widget getOldJournal() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //       color: HH_Colors.primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
          //   padding: EdgeInsets.all(5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Icon(
          //         Icons.arrow_back_ios_rounded,
          //         color: Colors.white,
          //       ),
          //       Text(
          //         '20th Oct to 14th Nov',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       Icon(
          //         Icons.arrow_forward_ios_rounded,
          //         color: Colors.white,
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
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
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                itemBuilder: (context, qIndex) {
                                  return Column(
                                    children: [
                                      Text(
                                        snapshot.data.result[index].questions[qIndex].question,
                                        style: TextStyle(
                                            color: HH_Colors.grey_585858,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data.result[index].questions[qIndex].answer,
                                        style: TextStyle(
                                            color: HH_Colors.grey_707070, fontSize: 14),
                                      ),
                                    ],
                                  );
                                }, 
                                itemCount: snapshot.data.result[index].questions.length, 
                                separatorBuilder: (BuildContext context, int index) {  
                                  return SizedBox(
                                        height: 10,
                                      );
                                },
                              ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    createdDate.format("hh:mm a"),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: HH_Colors.grey_707070,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
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
