import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
/// An arbitrary widget that lives in a popup menu
class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({ Key key, this.height, this.child }) : super(key: key);

  @override
  final Widget child;

  @override
  final double height;

  @override
  bool get enabled => false;

  @override
  _PopupMenuWidgetState createState() => new _PopupMenuWidgetState();

  @override
  bool represents(T value) {
    // sTODO: implement represents
    throw UnimplementedError();
  }
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}


class HHOptionButton extends StatelessWidget{

  final VoidCallback onClickCancel;
  final VoidCallback onClickReSchedule;
  HHOptionButton({this.onClickCancel, this.onClickReSchedule});


  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.all(0.0),
        width: 30.0,
          height: 30,// you can adjust the width as you need
        child: PopupMenuButton<String>(
            onSelected: (String value) {
              print("You selected $value");
            },
          // captureInheritedThemes: false,
            icon: Image.asset('assets/images/ic_option_menu.png', width: 20, height: 20,),
            itemBuilder: (BuildContext context) {
              return [
                new PopupMenuWidget(
                  child:
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child:  Column(
                        children: [
                          InkWell(
                            child: Text('cancel'),
                            onTap: (){ Navigator.pop(context, 'cancel');
                            onClickCancel();
                            },
                          ),
                          Container(
                            color: HH_Colors.borderGrey,
                            height: 0.5,
                            width: 50,
                          )
                          ,InkWell(
                            child: Text('re-schedule'),
                            onTap: (){ Navigator.pop(context, 're-schedule');
                            onClickReSchedule();
                            },
                          )
                        ],
                      ),

                    )
                ),
              ];
            }
        )
      );

  }
}

