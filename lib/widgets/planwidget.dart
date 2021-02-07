import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class PlanWidget extends StatefulWidget {

  String title;
  String program_type;
  String price = '0';
  String desc;

  bool enable;

  final VoidCallback onClick;

  PlanWidget({ Key key, @required this.title,@required  this.program_type,@required  this.desc,@required  this.price, this.onClick, this.enable}): super(key: key);


  @override
  PlanWidgetState createState() => PlanWidgetState();
}

class PlanWidgetState extends State<PlanWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),

      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme
                .of(context)
                .accentColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                style: TextStyle(color: Colors.white, fontSize: 22),),
              SizedBox.fromSize(size: Size(8, 8),),

              Text(widget.program_type, textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 15),),
              SizedBox.fromSize(size: Size(8, 8),),

              Text('\$'+widget.price.toString(), textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 44),),
              SizedBox.fromSize(size: Size(8, 8),),

              Expanded(child: SingleChildScrollView(
                child:
                // widget.desc.contains("div") ?
                Html(
                  data:widget.desc,
                  // style: {
                  //   "ul": Style(
                  //       color: HH_Colors.color_black,
                  //       fontSize: FontSize(15.0)
                  //   ),"p": Style(
                  //       color: HH_Colors.color_black,
                  //       fontSize: FontSize(15.0),
                  //   )
                  // },
                  // style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
                )
                  //     : Text(widget.desc, style: TextStyle(
                  // color: HH_Colors.color_707070,
                  // fontSize: 15,)),
                // textAlign: TextAlign.start,
                  // style: TextStyle(color: Colors.white, fontSize: 16),),

              )),
              SizedBox.fromSize(size: Size(8, 20),),

              widget.enable ?? true ? RaisedButton(
                  child: Text( widget.price.compareTo('0') == 1 ? AppLocalizations.of(context).buyNow : AppLocalizations.of(context).free, style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    widget.onClick();
                  },
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.fromLTRB(80, 20,80,20),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
              ): Container()

            ],
          ),
        ),
      ),
    );
  }
}