import 'package:flutter/material.dart';
import 'package:flutter_app/api/Therapist_service.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TherapistPage extends StatefulWidget {
  static const String RouteName = '/therapists';

  var therapists = [];

  TherapistPage({Key key, this.title}) : super(key: key);

  final String title;
  String token;
  var error = false;

  @override
  _TherapistState createState() => _TherapistState();
}

class _TherapistState extends State<TherapistPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget( title: widget.title,
            child:FutureBuilder<GetTherapistsResponse>(
                future: widget.title == "Therapist" ? getAllTherapists() :  widget.title == "Physician" ? getAllPhysicians() : getAllCasemanagers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text(HHString.error),);
                    }

                    if(snapshot.data.result.length == 0){
                      return Center(child: Text(HHString.no_record_found),);
                    }

                    // setState(() {
                    //   widget.therapists = snapshot.data.result;
                    // });

                    return ListView.separated(
                      itemCount: snapshot.data.result.length,
                      itemBuilder: (context, index) {
                        return TharapistCell(
                          name: snapshot.data.result[index].firstName + " " + snapshot.data.result[index].lastName,
                          role: snapshot.data.result[index].role,
                          image: snapshot.data.result[index].profilePic,
                          showBook: true,
                          onClick: () {
                            Navigator.pushNamed(context, BookSessionPage.RouteName, arguments: snapshot.data.result[index]);
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
}

class TherapistlOverlay extends ModalRoute<Widget> {
  static const String RouteName = '/select_therapist';

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This is a nice overlay',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss'),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class TherapistOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:         Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
         TherapistOptionItem(title: HHString.Therapist, image: 'assets/images/ic_therapist.png', onClick: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('Therapist',false));
          },),
          SizedBox(height: 50,),
          TherapistOptionItem(title: HHString.Physician, image: 'assets/images/ic_physician.png', onClick: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('Physician',false));
          },),
          SizedBox(height: 50,),
         TherapistOptionItem(title: HHString.case_manager, image: 'assets/images/ic_case_manager.png', onClick: (){

           Navigator.pop(context);
           Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('Case manager',false));

          }),
    ]),

    );
  }
}

class TherapistOptionItem extends StatelessWidget {
  var image;
  var title = "";
  final VoidCallback onClick;

  TherapistOptionItem(
      {@required this.title, @required this.image, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width/2.2,
          height: MediaQuery.of(context).size.width/2.7,

          padding: EdgeInsets.all(10),
          child: Container(child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                image,
                height: 70,
                width: 70,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 20, color: HH_Colors.grey_3d3d3d),
              ),
            ],
          ),)),
        ),
        onTap: (){
          onClick();
        },
      ),
    );
  }
}

class TherapistModel{
  Result result;

  TherapistModel({@required this.result});

}
