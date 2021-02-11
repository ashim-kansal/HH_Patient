import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/agora/pickup_layout.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/screens/FaqPage.dart';
import 'package:flutter_app/screens/aboutus.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/chatlist.dart';
import 'package:flutter_app/screens/feedback.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/library.dart';
import 'package:flutter_app/screens/myplan.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/privacy.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/screens/terms.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  static const String RouteName = '/home';

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var tabIndex = 0;
  String title = 'Dashboard';
  String name;
  String id;
  String email;
  String profileImage = "";
  bool showTherapist = false;
  int count = 0;

  List<Widget> listScreens;
  List<String> listNames = ['Dashboard', 'Library', 'My Assessment', ''];

  _updateFromHome(String s) {
    showTherapistOptions();
  }

  @override
  void initState() {
    super.initState();
    listScreens = [
      HomePage(onUpdateDashboard: _updateFromHome),
      LibraryPage(),
      MyAssessmentPage(),
      TherapistOptionsPage()
    ];

    count??0;
    getProfile();
  }

  void getProfile() {
    UserAPIServices userAPIServices = new UserAPIServices();

    userAPIServices.getProfile().then((value) => {
          if (value.responseCode == 200)
            {
              setState(() {
                name = value.result.firstName + " " + value.result.lastName;
                email = value.result.email;
                id = value.result.id;
                profileImage = value.result.profilePic;
                id = value.result.id;
                count = value.result.totalUnreadNotificationList??0;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) => PickupLayout(
      myId: id,
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text(
              tabIndex == 0
                  ? AppLocalizations.of(context).dashboard
                  : tabIndex == 1
                      ? AppLocalizations.of(context).library
                      : AppLocalizations.of(context).assessment,
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: new Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_on_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => {
                        Navigator.pushNamed(context, NotificationPage.RouteName)
                            .then((value) => {setState(() {})})
                      },
                    ),
                    showBadge()
                  ],
                ))
          ],
        ),
        drawer: Container(
          width: 320,
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
                  child: new GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, ProfilePage.RouteName)
                    },
                    child: Row(
                      children: [
                        profileImage == ""
                            ? Image.asset(
                                'assets/images/ic_avatar.png',
                                height: 50,
                                width: 50,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(profileImage),
                                radius: 30,
                                // Image.network(profileImage,
                                // height: 50,
                                // width: 50,),
                              ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              name ?? "Hi John Doe",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: HH_Colors.accentColor),
                            ),
                            FittedBox(
                              child: Text(
                                email ?? "john.doe@yahoo.com",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: HH_Colors.grey_35444D, fontSize: 12),
                              ),
                              fit: BoxFit.fill,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              HHDrawerItem(
                title: AppLocalizations.of(context).mychat,
                icon: 'assets/images/ic_chat.png',
                onClick: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ChatListPage.RouteName);
                },
              ),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: AppLocalizations.of(context).my_programs,
                  icon: 'assets/images/ic_prgrams.png',
                  onClick: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, CurrentPlansPage.RouteName);
                  }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                title: AppLocalizations.of(context).Settings,
                icon: 'assets/images/ic_settings.png',
                onClick: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingsPage.RouteName);
                },
              ),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              // HHDrawerItem(
              //     title: HHString.my_therapists, icon: 'assets/images/ic_therapists.png', onClick: (){
              //       Navigator.pop(context);
              //       Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('My Therapists',false));
              // },),
              // Container(
              //   color: HH_Colors.grey,
              //   height: 1,
              // ),
              HHDrawerItem(
                  title: AppLocalizations.of(context).Support,
                  icon: 'assets/images/ic_support.png'),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(
                title: AppLocalizations.of(context).Contact_Us,
                onClick: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FeedbackPage.RouteName);
                },
              ),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(
                  title: AppLocalizations.of(context).FAQ,
                  onClick: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, FaqPage.RouteName);
                  }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: AppLocalizations.of(context).more_info,
                  icon: 'assets/images/ic_info.png'),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(
                title: AppLocalizations.of(context).about_us,
                onClick: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutUs.RouteName,
                      arguments: ScreenArguments('About Us', false));
                },
              ),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(
                  title: AppLocalizations.of(context).tnc,
                  onClick: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, TermsPage.RouteName,
                        arguments:
                            ScreenArguments('Terms & Conditions', false));
                  }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(
                  title: AppLocalizations.of(context).privacy,
                  onClick: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, PrivacyPolicy.RouteName,
                        arguments: ScreenArguments('Privacy Policy', false));
                  }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: AppLocalizations.of(context).logout,
                  icon: 'assets/images/ic_logout.png',
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return DialogWithButtons(onLogoutPress: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.remove("token");

                          Navigator.pop(context);
                          Navigator.pushNamed(context, LoginPage.RouteName);
                        }, onDenyPress: () {
                          Navigator.pop(context);
                        });
                      },
                    );
                  }),
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
                if (index < 3) {
                  tabIndex = index;
                } else {
                  showTherapistOptions();
                }
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  tabIndex == 0
                      ? 'assets/images/ic_home_select.png'
                      : 'assets/images/ic_home.png',
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context).home),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  tabIndex == 1
                      ? 'assets/images/ic_library_select.png'
                      : 'assets/images/ic_library.png',
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context).library),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  tabIndex == 2
                      ? 'assets/images/ic_tab_assessment_select.png'
                      : 'assets/images/ic_tab_assessment.png',
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context).assessment),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  tabIndex == 3
                      ? 'assets/images/ic_therapists_select.png'
                      : 'assets/images/ic_therapists.png',
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context).therapists),
              ),
            ]),
        body: Material(
            color: Theme.of(context).accentColor,
            child: Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    color: Colors.white),
                child: tabIndex < 3
                    ? listScreens[tabIndex]
                    : showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return DialogWithButtons(onLogoutPress: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, LoginPage.RouteName);
                          }, onDenyPress: () {
                            Navigator.pop(context);
                          });
                        }))),
      ));

  showTherapistOptions() {
    print(tabIndex);
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Color(0x90000000),
      builder: (BuildContext dialogContext) {
        return TherapistOptionsPage();
      },
    );
  }

  Widget showBadge() {
    return (count??0) > 0
        ? new Positioned(
            right: 0,
            child: new Container(
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.all(10),
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
            ),
          )
        : Container();
  }
}
