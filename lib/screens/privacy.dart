import 'package:flutter/material.dart';
import 'package:flutter_app/api/StaticContent.dart';
import 'package:flutter_app/model/StaticContentModel.dart';
import 'package:flutter_app/utils/colors.dart';

class PrivacyPolicy extends StatefulWidget {
  static const String RouteName = '/privacy';

  PrivacyPolicy({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<PrivacyPolicy> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy', style: TextStyle(color: Colors.white)),
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Material(
                     child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        color: Colors.white,
                        child: FutureBuilder<StaticContent>(
                          future: getStaticContent("PRIVACY_POLICY"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if(snapshot.hasError){
                                return Text("Error");
                              }
                              return  Container(
                                // height: MediaQuery.of(context).size.height,
                                child: Text(
                                      snapshot.data.result.description,
                                      style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
                                    )
                                    
                              );
                            }else
                              return Container(
                                child: Center(child: CircularProgressIndicator(),),
                              );
                          },
                        )
                      ),
                  ),
                  
                ],
              )),
        ));
  }
}