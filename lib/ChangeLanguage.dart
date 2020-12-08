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
                              child:Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
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
                              ),
                              )
                            ),
                            flex: 1,
                          )
                        ],
                      )),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: HHButton(title: "Get Started", type: 2, isEnable: true, onClick: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MyGoals.RouteName);

                          }),
                        ))),
              ],
            )));
  }
}
