import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils/DateTimeUtils.dart';
import 'package:simple_moment/simple_moment.dart';

class HHButton extends StatelessWidget {
  var title = "";
  var type = 1;
  double textSize = 22;
  final VoidCallback onClick;
  bool isEnable = true;

  HHButton(
      {@required this.title,
      @required this.type,
      this.onClick,
      this.isEnable,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      elevation: 5.0,
      // color: isEnable ? HH_Colors.,
      // color: type == 1
      //     ? Theme.of(context).primaryColor
      //     : type == 2 ? HH_Colors.orange_FF8A73 : HH_Colors.purpleColor,
      color: type == 1
          ? (isEnable ?? false
              ? Theme.of(context).primaryColor
              : HH_Colors.color_F2EEEE)
          : type == 2
              ? HH_Colors.orange_FF8A73
              : type == 4
                  ? HH_Colors.purpleColor
                  : isEnable ?? false
                      ? Theme.of(context).accentColor
                      : HH_Colors.color_F2EEEE,
      onPressed: () {
        onClick();
      },
      child: Text(
        title,
        style: TextStyle(
            color: isEnable ?? true ? Colors.white : HH_Colors.color_949494,
            fontSize: textSize ?? 22,
            fontWeight: FontWeight.w500,
            fontFamily: "ProximaNova"),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class HHSmallButton extends StatelessWidget {
  var title = "";
  var type = 1;
  var textSize = 16;
  final VoidCallback onClick;
  bool isEnable = true;

  HHSmallButton(
      {@required this.title,
      @required this.type,
      this.onClick,
      this.isEnable,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: MaterialButton(
        minWidth: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          // side: BorderSide(color: Colors.red)
        ),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        elevation: 5.0,
        color: type == 1
            ? (isEnable ?? false
                ? Theme.of(context).primaryColor
                : HH_Colors.color_F2EEEE)
            : type == 2
                ? HH_Colors.orange_FF8A73
                : type == 4
                    ? HH_Colors.purpleColor
                    : isEnable ?? false
                        ? Theme.of(context).accentColor
                        : HH_Colors.color_F2EEEE,
        onPressed: () {
          onClick();
        },
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: textSize ?? 16,
              fontWeight: FontWeight.w500,
              fontFamily: "ProximaNova"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class HHHomeButton extends StatelessWidget {
  var title = "";
  var type = 1;
  final VoidCallback onClick;

  HHHomeButton({@required this.title, @required this.type, this.onClick});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.only(left: 20),
      color: HH_Colors.accentColor,
      onPressed: () {
        onClick();
      },

      focusColor: HH_Colors.accentColor,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: "ProximaNova"),
            textAlign: TextAlign.start,
          ),
          Container(
            color: HH_Colors.light_accentcolor,
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HHDrawerItem extends StatelessWidget {
  var title = "";
  var icon = "";
  final VoidCallback onClick;

  HHDrawerItem({@required this.title, @required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontFamily: "ProximaNova"),
              )
            ],
          ),
        ));
  }
}

class HHDrawerItem2 extends StatelessWidget {
  var title = "";
  final VoidCallback onClick;

  HHDrawerItem2({@required this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: HH_Colors.grey_707070,
                      fontSize: 18,
                      fontFamily: "ProximaNova"),
                )
              ],
            )));
  }
}

class HHTextView extends StatelessWidget {
  var title;
  double size;
  var color;
  var alignment = TextAlign.left;
  var textweight = FontWeight.w200;

  HHTextView(
      {@required this.title,
      @required this.size,
      @required this.color,
      this.alignment,
      this.textweight});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: alignment ?? TextAlign.left,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontFamily: "ProximaNova",
            fontWeight: textweight ?? FontWeight.w300));
  }
}

class HHTextViewBoarder extends StatelessWidget {
  var title;
  double size;
  var color;

  HHTextViewBoarder(
      {@required this.title, @required this.size, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: color, fontSize: size));
  }
}

//
class HHEditFormText extends StatefulWidget {
  final String hint;
  final String text = "";
  final TextEditingController controller;

  final VoidCallback onClickEye;
  final VoidCallback onSubmitText;

  final VoidCallback onFieldSubmit;

  var minLines = 1;
  var maxLength = 1;
  var error = false;
  var errorText = "";
  var obscureText = false;
  var enabled = true;
  var showeye = false;
  var textarea = false;

  // var controller = null;
  var inputType = TextInputType.text;
  final ValueChanged<String> onSelectAnswer;

  final TextInputAction textInputAction;

  HHEditFormText(
      {Key key,
      this.hint,
      this.minLines,
      this.error,
      this.errorText,
      this.obscureText,
      this.inputType,
      this.maxLength,
      this.controller,
      this.onClickEye,
      this.textarea,
      this.enabled,
      this.showeye,
      this.onSubmitText,
      this.onFieldSubmit,
      this.textInputAction,
      this.onSelectAnswer})
      : super(key: key);

  @override
  HHEditFormTextState createState() => HHEditFormTextState();
}

class HHEditFormTextState extends State<HHEditFormText> {
  // final TextEditingController controller = TextEditingController();

  void Function() param2;

  @override
  void initState() {
    super.initState();
    if (widget.minLines == null) widget.minLines = 1;
    widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction ?? TextInputAction.none,
      enabled: widget.enabled ?? true,
      // obscureText: widget.obscureText != null && widget.error ? true : false,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      minLines: widget.minLines ?? 1,
      maxLength: widget.maxLength ?? 32,
      maxLines: widget.minLines ?? 1,
      onChanged: (text) {
        if (widget.onSelectAnswer != null) widget.onSelectAnswer(text);
      },
      onFieldSubmitted: (term) {
        widget.onFieldSubmit();
      },
      // onEditingComplete: () => widget.onSubmitText(),
      decoration: InputDecoration(
          counterText: "",
          hintStyle: TextStyle(
              fontFamily: "ProximaNova",
              fontSize: 15,
              color: Color(0xff707070)),
          errorText:
              widget.error != null && widget.error ? widget.errorText : null,
          errorStyle: TextStyle(color: Color(0xffff8a73)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Color(0xffff8a73))),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.hint == null ? "" : widget.hint,
          errorBorder: errorOutlineInputBorder(),
          border: normalOutlineInputBorder(),
          suffixIcon: widget.showeye ?? false
              ? IconButton(
                  icon: Icon(
                      widget.obscureText ?? false
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 20,
                      color: Color(0xffCBCBCB)),
                  onPressed: () => widget.onClickEye(),
                )
              : null),
    );
  }
}

class HHEditText extends StatefulWidget {
  final String hint;
  final String text = "";
  final TextEditingController controller;

  final VoidCallback onClickEye;
  final VoidCallback onSubmitText;

  var minLines = 1;
  var maxLength = 1;
  var error = false;
  var errorText = "";
  var obscureText = false;
  var enabled = true;
  var showeye = false;
  var textarea = false;

  // var controller = null;
  var inputType = TextInputType.text;
  final ValueChanged<String> onSelectAnswer;


  HHEditText(
      {Key key,
      this.hint,
      this.minLines,
      this.error,
      this.errorText,
      this.obscureText,
      this.inputType,
      this.maxLength,
      this.controller,
      this.onClickEye,
      this.textarea,
      this.enabled,
      this.showeye,
      this.onSubmitText,
      this.onSelectAnswer})
      : super(key: key);

  @override
  HHEditTextState createState() => HHEditTextState();
}

class HHEditTextState extends State<HHEditText> {
  // final TextEditingController controller = TextEditingController();

  void Function() param2;

  @override
  void initState() {
    super.initState();
    if (widget.minLines == null) widget.minLines = 1;
    widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled ?? true,
      // obscureText: widget.obscureText != null && widget.error ? true : false,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      minLines: widget.minLines ?? 1,
      maxLength: widget.maxLength ?? 32,
      maxLines: widget.minLines ?? 1,
      keyboardType: widget.inputType??TextInputType.text,
      onChanged: (text) {
        if (widget.onSelectAnswer != null) widget.onSelectAnswer(text);
      },
      onSubmitted: (value) {
        return;
      },
      // onEditingComplete: () => widget.onSubmitText(),
      decoration: InputDecoration(
          counterText: "",
          hintStyle: TextStyle(
              fontFamily: "ProximaNova",
              fontSize: 15,
              color: Color(0xff707070)),
          errorText:
              widget.error != null && widget.error ? widget.errorText : null,
          errorStyle: TextStyle(color: Color(0xffff8a73)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Color(0xffff8a73))),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.hint == null ? "" : widget.hint,
          errorBorder: errorOutlineInputBorder(),
          border: normalOutlineInputBorder(),
          suffixIcon: widget.showeye ?? false
              ? IconButton(
                  icon: Icon(
                      widget.obscureText ?? false
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 20,
                      color: Color(0xffCBCBCB)),
                  onPressed: () => widget.onClickEye(),
                )
              : null),
    );
  }
}

class UndefinedView extends StatelessWidget {
  final String name;

  const UndefinedView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Route for $name is not defined',
          style: TextStyle(fontFamily: "ProximaNova"),
        ),
      ),
    );
  }
}

class CalenderCell extends StatelessWidget {
  var day;
  var date;

  CalenderCell({Key key, this.day, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
                fontSize: 12,
                color: HH_Colors.grey_585858,
                fontFamily: "ProximaNova"),
          ),
          Text(
            date,
            style: TextStyle(
                fontSize: 12,
                color: HH_Colors.grey_585858,
                fontFamily: "ProximaNova"),
          )
        ],
      ),
    );
  }
}

class DrinkingDiaryCell extends StatelessWidget {
  Result data;
  String day;
  final VoidCallback onClickGoal;

  DrinkingDiaryCell({this.day, this.data, this.onClickGoal});

  bool isToday(String day){
    String currentDay = Moment.parse(DateTime.now().toString()).format("EEE");
    return currentDay==day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          border: Border.all(color: HH_Colors.borderGrey, width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                day,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: HH_Colors.primaryColor,
                    fontFamily: "ProximaNova",),
              ),
              SizedBox(
                width: 10,
              ),
              (data != null && data.setGoal != null)
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: HH_Colors.color_FFECE8,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.library_add_check_outlined,
                            color: HH_Colors.color_949494,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(((data.setGoal ?? 0) <10?'0'+(data.setGoal ?? 0).toString() :(data.setGoal ?? 0).toString()) + ' units',
                              style: TextStyle(
                                  color: HH_Colors.color_949494, fontSize: 14))
                        ],
                      ))
                  : Container(),
              SizedBox(
                width: 10,
              ),
              (data != null && data.achivedGoal != null)
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: HH_Colors.green_3DDB8C,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.library_add_check_outlined,
                            color: HH_Colors.color_949494,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(((data.achivedGoal ?? 0) <10?'0'+(data.achivedGoal ?? 0).toString() :(data.achivedGoal ?? 0).toString()) + ' units',
                              style: TextStyle(
                                  color: HH_Colors.color_949494, fontSize: 14))
                        ],
                      ))
                  : Container(),
            ],
          ),
          InkWell(
            onTap: () {
              isToday(day) ? onClickGoal():null;

            },
            child:  Row(
                    children: [
                      Icon(
                        Icons.add_circle_outlined,
                        color: isToday(day)
                            ? HH_Colors.primaryColor
                            : HH_Colors.color_949494,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).goal,
                        style: TextStyle(
                            fontSize: 14,
                            color: (data!= null && data.date != null && data.date.isSameDate(DateTime.now()))
                                ? HH_Colors.accentColor
                                : HH_Colors.color_949494,
                            fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}

// dialog

class DialogWithImage extends StatelessWidget {
  final String title;
  final String content;
  final String imageSrc;
  final List<Widget> actions;
  VoidCallback onClick;

  DialogWithImage({
    this.title,
    this.content,
    this.onClick,
    this.imageSrc,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: 220,
          width: 200,
          child: new GestureDetector(
            onTap: (){
              onClick();
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        // onClick();
                      },
                      child: Container(
                        child: Center(
                          child: Image.asset(
                            imageSrc??"assets/images/thumb.png",
                            height: 80,
                            width: 80,
                          )
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  HHTextView(
                    title: title??"",
                    size: 18,
                    textweight: FontWeight.w600,
                    color: HH_Colors.color_3D3D3D,
                    alignment: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  HHTextView(
                    title: content,
                    size: 16,
                    textweight: FontWeight.w300,
                    color: HH_Colors.color_707070,
                    alignment: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class DialogWithButtons extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  final VoidCallback onLogoutPress;
  final VoidCallback onDenyPress;

  DialogWithButtons({
    this.title,
    this.content,
    this.onLogoutPress,
    this.onDenyPress,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          constraints: BoxConstraints(
              minHeight: 150, minWidth: double.infinity, maxHeight: 170),
          // height: 150,
          // width: 200,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Column(
                  children: [
                    HHTextView(
                        title: AppLocalizations.of(context).logout,
                        size: 22,
                        color: HH_Colors.color_3D3D3D,
                        textweight: FontWeight.w600),
                    SizedBox(height: 20),
                    HHTextView(
                        title: AppLocalizations.of(context).logoutDesc,
                        size: 16,
                        color: HH_Colors.color_707070,
                        alignment: TextAlign.center,
                        textweight: FontWeight.w300)
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: HH_Colors.borderGrey, width: 0.5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                            onTap: () => {
                                  onDenyPress(),
                                },
                            child: HHTextView(
                                title: AppLocalizations.of(context).no,
                                size: 18,
                                color: HH_Colors.color_707070,
                                textweight: FontWeight.w400)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => {onLogoutPress()},
                          child: HHTextView(
                              title: AppLocalizations.of(context).yes,
                              size: 18,
                              color: HH_Colors.color_707070,
                              textweight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CancelDialog extends StatelessWidget {
  final VoidCallback onYesPress;
  final VoidCallback onDenyPress;

  CancelDialog({
    this.onYesPress,
    this.onDenyPress,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          constraints: BoxConstraints(
              minHeight: 150, minWidth: double.infinity, maxHeight: 170),
          // height: 150,
          // width: 200,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Column(
                  children: [
                    HHTextView(
                        title: AppLocalizations.of(context).cancelSession,
                        size: 22,
                        color: HH_Colors.color_3D3D3D,
                        textweight: FontWeight.w600),
                    SizedBox(height: 5),
                    HHTextView(
                        title:
                            AppLocalizations.of(context).cancelSessionDesc,
                        size: 16,
                        color: HH_Colors.color_707070,
                        alignment: TextAlign.center,
                        textweight: FontWeight.w400)
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: HH_Colors.borderGrey, width: 0.5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                            onTap: () => {
                                  onDenyPress(),
                                },
                            child: HHTextView(
                                title: AppLocalizations.of(context).no,
                                size: 18,
                                color: HH_Colors.color_707070,
                                textweight: FontWeight.w400)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => {onYesPress()},
                          child: HHTextView(
                              title: AppLocalizations.of(context).yes,
                              size: 18,
                              color: HH_Colors.color_707070,
                              textweight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class DialogWithField extends StatefulWidget {
  final String date;
  final VoidCallback onClick;
  int mCount = 0;
  final ValueChanged<int> count;

  DialogWithField({this.date, this.onClick, this.count
      // this.content,
      // this.actions = const [],
      });

  @override
  State<StatefulWidget> createState() => DialogWithFieldState();
}

class DialogWithFieldState extends State<DialogWithField> {
  @override
  void initState() {
    widget.mCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd EEEE/MM/yyyy'); //"12th Thursday/10/2020"
    String formattedDate = formatter.format(now);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 250,
        width: 200,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: HHTextView(
                  title: formattedDate,
                  size: 15,
                  color: HH_Colors.color_707070,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: HHTextView(
                  title: AppLocalizations.of(context).noOfDrinks,
                  size: 22,
                  color: HH_Colors.color_3D3D3D,
                  textweight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 164,
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(width: 1, color: HH_Colors.borderGrey)),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.mCount =
                                widget.mCount == 0 ? 0 : widget.mCount - 1;
                          });
                        },
                        child: Container(
                          width: 40,
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: HH_Colors.color_949494, fontSize: 22),
                            ),
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 40,
                        child: Container(
                          color: HH_Colors.borderGrey,
                        ),
                      ),
                      Container(
                        width: 80,
                        child: Center(
                            child: Text(
                          widget.mCount.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        )),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                      SizedBox(
                        width: 1,
                        height: 40,
                        child: Container(
                          color: HH_Colors.borderGrey,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.mCount = widget.mCount + 1;
                          });
                        },
                        child: Container(
                          width: 40,
                          child: Text(
                            "+",
                            style: TextStyle(color: HH_Colors.accentColor),
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Center(
                      child: RaisedButton(
                    onPressed: () {
                      widget.count(widget.mCount);
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context).save,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: HH_Colors.purpleColor,
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// NOTIFICATION

class NotificationList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String id;
  VoidCallback onDeleteClick;

  NotificationList(
      {@required this.id,
      @required this.title,
      @required this.subtitle,
      this.onDeleteClick});

  @override
  Widget build(BuildContext context) {
    return new Container(
        // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      // actionExtentRatio: 0.25,
      child: new Container(
          // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          // height: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
              //  color: HH_Colors.color_F3F3F3,
              ),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  color: HH_Colors.color_F3F3F3,
                  child: new ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HHTextView(
                          title: this.title,
                          color: HH_Colors.grey_35444D,
                          size: 16,
                          textweight: FontWeight.w400,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: HHTextView(
                            title: this.subtitle,
                            color: HH_Colors.color_92ABBB,
                            size: 14,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          )),
      secondaryActions: <Widget>[
        Container(
          // height: MediaQuery.of(context).size.width / 4,
          // margin: EdgeInsets.only(bottom: 5),
          child: new IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => {onDeleteClick()},
          ),
        )
      ],
    ));
  }
}

class DialogWithSingleButton extends StatelessWidget {
  final String title;
  final String content;

  final VoidCallback onLogoutPress;
  final VoidCallback onDenyPress;

  DialogWithSingleButton({
    this.title,
    this.content,
    this.onLogoutPress,
    this.onDenyPress,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: 170,
          width: 170,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Column(
                  children: [
                    HHTextView(
                        title: title,
                        size: 22,
                        color: HH_Colors.color_3D3D3D,
                        textweight: FontWeight.w600),
                    SizedBox(height: 20),
                    HHTextView(
                        title: content,
                        size: 16,
                        color: HH_Colors.color_707070,
                        alignment: TextAlign.center,
                        textweight: FontWeight.w400)
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: HH_Colors.borderGrey, width: 0.5))),
                  child: Center(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                          onTap: () => {
                                // onDenyPress(),
                                Navigator.pop(context)
                              },
                          child: HHTextView(
                              title: AppLocalizations.of(context).ok,
                              size: 18,
                              color: HH_Colors.color_707070,
                              textweight: FontWeight.w400)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ScoreDialog extends StatelessWidget {
  final String title;
  final String content;

  final VoidCallback onPressOk;

  ScoreDialog({
    this.title,
    this.content,
    this.onPressOk,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: 170,
          width: 170,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Column(
                      children: [
                        HHTextView(
                            title: title??'',
                            size: 22,
                            color: HH_Colors.color_3D3D3D,
                            textweight: FontWeight.w600),
                        SizedBox(height: 20),
                        HHTextView(
                            title: content??'',
                            size: 16,
                            color: HH_Colors.color_707070,
                            alignment: TextAlign.center,
                            textweight: FontWeight.w400)
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: HH_Colors.borderGrey, width: 0.5))),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                          onTap: () => {
                            // Navigator.pop(context)
                            onPressOk()
                          },
                          child: HHTextView(
                              title: AppLocalizations.of(context).ok,
                              size: 18,
                              color: HH_Colors.color_707070,
                              textweight: FontWeight.w400)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


class ToastMessage extends StatelessWidget {
  String message = "";
  String type = "";

  ToastMessage({@required this.message, @required this.type});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

OutlineInputBorder normalOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Color(0xffD9D7D7), width: 0.3),
  );
}

OutlineInputBorder errorOutlineInputBorder() {
  return OutlineInputBorder(
    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Color(0xffff8a73)),
  );
}
