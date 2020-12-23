import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/model/GetBookingSlotsResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart' as Therapist;
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/schedule_widgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';
import 'package:meta/meta.dart';

class BookSessionPage extends StatefulWidget{

  static const String RouteName = '/schedule';

  Therapist.Result data;

  BookSessionPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookSessionState();

}

class BookSessionState extends State<BookSessionPage>{

  @override
  Widget build(BuildContext context){
    return MyWidget(title: 'Schedule', child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TharapistCell(name: widget.data.firstName+' '+widget.data.lastName, role: widget.data.role,
                    image: widget.data.profilePic, showBook: false, onClick: (){},),
                  FutureBuilder<GetBookingSlotsResponse>(
                      future: getSlotsForBooking(widget.data.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text("Error");
                          }
                          return Expanded(child: Column(
                            children: [
                              Container(height:50, child: SessionDateWidget(list:snapshot.data.result)),
                              SizedBox(height: 10,),
                              Expanded(child: GridViewWidget(),),
                            ],
                          ));
                        } else
                          return Container(
                            child: Center(child: CircularProgressIndicator(),),
                          );
                      }),

                  Container(
                      child: HHButton(title: 'Save', type: 4, isEnable: true,onClick: (){
                        Navigator.pushNamed(context, SessionPage.RouteName);
                      },)
                  )
                ],
              )
              // backgroundColor: Colors.white,
              // This trailing comma makes auto-formatting nicer for build methods.

    );

  }
}