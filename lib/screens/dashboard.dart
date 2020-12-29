import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/login.dart';
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
  String email;
  String profileImage = "";

  List<Widget> listScreens;
  List<String> listNames = [
    'Dashboard',
    'Library',
    'My Assessment',
    ''
  ];
  @override
  void initState() {
    super.initState();
    listScreens = [
      HomePage(),
      LibraryPage(),
      MyAssessmentPage(),
      TherapistOptionsPage()
    ];

    getProfile();
  }

  void getProfile() {
    UserAPIServices userAPIServices = new UserAPIServices();

    userAPIServices.getProfile().then((value) => {
      if (value.responseCode == 200) {
        setState(() {
          name = value.result.firstName+" "+value.result.lastName;
          email = value.result.email;
          profileImage = value.result.profilePic;
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) =>

      Scaffold(
        
        appBar: AppBar(
          title: Text(title, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton( 
                icon: Icon(
                    Icons.notifications_on_outlined,
                    color: Colors.white, ),
                    onPressed: () => {
                      Navigator.pushNamed(context, NotificationPage.RouteName)
                    },
              )
            )
          ],
        ),
        drawer: Container(
          width: 300,
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
                      profileImage == ""?
                      Image.asset(
                        'assets/images/ic_avatar.png',
                        height: 50,
                        width: 50,
                      ) : CircleAvatar(
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
                          Text(name??"Hi John Doe", textAlign:TextAlign.start, style: TextStyle(color: HH_Colors.accentColor),),
                          FittedBox(
                            child: Text(email??"john.doe@yahoo.com", textAlign:TextAlign.start, style: TextStyle(color: HH_Colors.grey_35444D, fontSize: 12),),
                            fit: BoxFit.fill,
                            )
                        ],
                        
                      )
                    ],
                  ),
                )
               
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
                  title: "My Programs", icon: 'assets/images/ic_prgrams.png', onClick: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, CurrentPlansPage.RouteName);
              }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "Settings", icon: 'assets/images/ic_settings.png', onClick: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SettingsPage.RouteName);
              },),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "My Therapists", icon: 'assets/images/ic_therapists.png', onClick: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('My Therapists',false));
              },),
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
              HHDrawerItem2(title: "Give Us Feedback", onClick: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, FeedbackPage.RouteName);
              },),
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
              HHDrawerItem2(title: "About Us", onClick: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutUs.RouteName, arguments: ScreenArguments('About Us',false ));
              },),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "Terms & Conditions", onClick: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, TermsPage.RouteName, arguments: ScreenArguments('Terms & Conditions',false ));
              }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem2(title: "Privacy Policy", onClick: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, PrivacyPolicy.RouteName, arguments: ScreenArguments('Privacy Policy',false ));
              }),
              Container(
                color: HH_Colors.grey,
                height: 1,
              ),
              HHDrawerItem(
                  title: "Log Out", icon: 'assets/images/ic_logout.png',
                  onClick: (){
                    showDialog(context: context,
                       builder: (BuildContext dialogContext) {
                        return DialogWithButtons(
                          onLogoutPress: ()async {

                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.remove("token");

                            Navigator.pop(context);
                            Navigator.pushNamed(context, SelectLanguage.RouteName);
                          },
                          onDenyPress: (){
                            Navigator.pop(context);
                          }
                        );
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
               if(index< 3){
                 tabIndex = index;
                 title = listNames[tabIndex];
               }else{
                 showTherapistOptions();
               }
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(tabIndex == 0? 'assets/images/ic_home_select.png': 'assets/images/ic_home.png', height: 25, width: 25,),
                title: Text('Home'),

  ),
              BottomNavigationBarItem(
                icon: Image.asset(tabIndex == 1?'assets/images/ic_library_select.png':'assets/images/ic_library.png', height: 25, width: 25,),
                title: Text('Library'),

              ),
              BottomNavigationBarItem(
                icon: Image.asset(tabIndex == 2?'assets/images/ic_tab_assessment_select.png':'assets/images/ic_tab_assessment.png' , height: 25, width: 25,),
                title: Text('Assessment'),
              ),BottomNavigationBarItem(
                icon: Image.asset(tabIndex == 3?'assets/images/ic_therapists_select.png':'assets/images/ic_therapists.png' , height: 25, width: 25,),
                title: Text('Therapists'),
              ),
            ]
        ),

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
              child: tabIndex<3 ? listScreens[tabIndex] : showDialog(context: context,
              builder: (BuildContext dialogContext){
                return  DialogWithButtons(
                    onLogoutPress: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, LoginPage.RouteName);
                    },
                    onDenyPress: (){
                      Navigator.pop(context);
                    }
                );
              })
            )
          ),
      );

  showTherapistOptions() {
    print(tabIndex);
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Color(0x90000000),
      builder: (BuildContext dialogContext) {
        return  TherapistOptionsPage();

      },
    );
  }
}
