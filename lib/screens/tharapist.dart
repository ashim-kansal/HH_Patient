import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

class TherapistPage extends StatefulWidget {
  static const String RouteName = '/therapists';
  final therapists = [
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
  ];

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
              child: ListView.separated(
                itemCount: widget.therapists.length,
                itemBuilder: (context, index) {
                  return TharapistCell(
                    name: widget.therapists[index],
                    role: "Recovery Coach",
                    showBook: true,
                    onClick: () {
                      Navigator.pushNamed(context, BookSessionPage.RouteName);
                    },
                  );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body:         Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            TherapistOptionItem(title: 'Therapist', image: 'assets/images/ic_therapist.png'),
            SizedBox(height: 50,),
            TherapistOptionItem(title: 'Physician', image: 'assets/images/ic_therapist.png'),
            SizedBox(height: 50,),
            TherapistOptionItem(title: 'Case manager', image: 'assets/images/ic_therapist.png'),
          ],
        )),

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
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
        child: Column(
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
        ),
      ),
    );
  }
}
