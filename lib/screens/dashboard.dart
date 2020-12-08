import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class Dashboard extends StatefulWidget {
  static const String RouteName = '/home';

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var tabIndex = 0;

  List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      HomePage(),
      MyAssessmentPage(),
      TherapistPage(),
      TherapistOptionsPage()
    ];
  }
  @override
  Widget build(BuildContext context) =>

      Scaffold(
        appBar: AppBar(
          title: Text('Dashboard', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
        ),
        drawer: Container(
          width: 260,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/ic_close.png',
                      height: 20,
                      width: 20,
                    ),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_avatar.png',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Hi John Doe", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.accentColor),),
                        Text("john.doe@yahoo.com", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_35444D),),
                      ],
                    )
                  ],
                ),
              ),
              HHDrawerItem(
                  title: "My Chats", icon: 'assets/images/ic_chat.png', onClick: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, ChatListPage.RouteName);
              },),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "My Programs", icon: 'assets/images/ic_prgrams.png'),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "Settings", icon: 'assets/images/ic_settings.png'),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "Support", icon: 'assets/images/ic_support.png'),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "Give Us Feedback"),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "FAQ's"),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "More Information", icon: 'assets/images/ic_info.png'),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "About Us"),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "Terms & Conditions"),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "Privacy Policy"),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "Log Out", icon: 'assets/images/ic_logout.png'),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: HH_Colors.accentColor,
            unselectedItemColor: HH_Colors.grey_707070,
            unselectedLabelStyle: TextStyle(color: HH_Colors.grey_707070),
            backgroundColor: Colors.white,
            currentIndex: tabIndex,
            onTap: (int index) {
              setState(() {
                tabIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/ic_library.png', height: 20, width: 20,),
                title: Text('Library'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Assessment'),
              ),BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Therapists'),
              ),
            ]
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
              child: listScreens[tabIndex]
            )
          ),
      );
}
