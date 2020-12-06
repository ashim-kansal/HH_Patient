import 'package:flutter/material.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

class TherapistPage extends StatefulWidget {
  static const String RouteName = '/therapists';
  final therapists = ['abcd', 'abcd', 'abcd', 'abcd', 'abcd', 'abcd', ];

  TherapistPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _TherapistState createState() => _TherapistState();
}

class _TherapistState extends State<TherapistPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Therapist', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child:ListView.separated(
                itemCount: widget.therapists.length,
                itemBuilder: (context, index) {
                return TharapistCell(name: widget.therapists[index],role: "Recovery Coach", showBook: true, onClick: (){
                  Navigator.pushNamed(context, BookSessionPage.RouteName);
                },);

                },
                separatorBuilder: (context, index) {
                return Divider();
                },
          ),
          // backgroundColor: Colors.white,
          // This trailing comma makes auto-formatting nicer for build methods.
        )));
  }
}
