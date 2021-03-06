import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/StaticContent.dart';
import 'package:flutter_app/model/FaqResponse.dart';
import 'package:flutter_app/model/StaticContentModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';

class FaqPage extends StatefulWidget {
  static const String RouteName = '/FaqPage';

  var error = false;

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(
          title: AppLocalizations.of(context).FAQ,
      child: FutureBuilder<FaqResponse>(
        future: getFaqs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return Center(child: Text(AppLocalizations.of(context).not_data_found),);
            }
            return  Container(
              // height: MediaQuery.of(context).size.height,
                child:ListView.separated(
                  itemCount: snapshot.data.result.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data.result[index].question,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 16,
                                color: HH_Colors.grey_707070,
                                fontFamily: "ProximaNova")),
                        Text(snapshot.data.result[index].answer,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 16,
                                color: HH_Colors.grey_707070,
                                fontWeight: FontWeight.w600,
                                fontFamily: "ProximaNova"))
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                )

            );
          }else
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
        },
      )


    );
  }
}
