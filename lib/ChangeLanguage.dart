import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class SelectLanguage extends StatefulWidget {
  static const String RouteName = '/language';

  @override
  State<StatefulWidget> createState() => SelectLanguageState();
}

class SelectLanguageState extends State<StatefulWidget> {
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            color: Color(0xfff2eeee),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Center(
                                child:Image.asset('assets/images/ic_appicon_blue.png', height: 180,width: 150,)
                            ),
                            flex: 4,
                          ),
                          Flexible(
                            child: Material(
                              color: Colors.white,
                              child: Column(children: [
                                Text(
                                  "Select Language",
                                  style: TextStyle(color: Color(0xff949494), fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  padding:  const EdgeInsets.only(left: 20.0,right: 10.0),
                                  width: 230.0,
                                  // padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Color(0xffE9E7E7)),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                
                                child: DropdownButtonHideUnderline(
                                  
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconEnabledColor: Color(0xffC5C4C4),
                                  iconSize: 38,
                                  elevation: 16,
                                  style: TextStyle(color: Color(0xff707070)),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>['English',  'Français', 'Español']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),) 
                                )
                              ],)
                              
                            ),
                            flex: 1,
                          )
                        ],
                      )),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                        width: 340,
                        padding: EdgeInsets.all(20.0),
                        child: Center(
<<<<<<< HEAD
                          child: HHButton(title: "Get Started", 
                          type: 2, 
                          isEnable: true,
                          onClick: (){
=======
                          child: HHButton(title: "Get Started", type: 2, isEnable: true, onClick: (){
>>>>>>> fd2e5939107816206a070aed30ac7709bb382bc4
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MyGoals.RouteName);
                          }),
                        ))),
              ],
            )));
  }
}
