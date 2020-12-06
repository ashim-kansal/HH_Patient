import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class HHButton extends StatelessWidget {
  var title = "";
  var type = 1;
  final VoidCallback onClick;

  HHButton({@required this.title, @required this.type, this.onClick});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: Colors.white,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      elevation: 5.0,
      color: type == 1
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      onPressed: () {
        onClick();
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
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
                    color: Theme.of(context).accentColor, fontSize: 18),
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
          child:Row(
              children: [
                SizedBox(width: 40,),
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: HH_Colors.grey_707070, fontSize: 18),
                )
              ],
          )
        ));
  }
}


class HHEditText extends StatefulWidget {
  final String hint;
  final String text = "";
  var minLength = 8;
  var maxLength = 8;
  var error = false;
  var errorText = "";
  var obscureText = false;
  var controller = null;
  var inputType = TextInputType.text;

  HHEditText(
      {Key key,
      this.hint,
      this.minLength,
      this.maxLength,
      this.error,
      this.errorText,
      this.obscureText,
      this.inputType,
      this.controller})
      : super(key: key);

  @override
  HHEditTextState createState() => HHEditTextState();
}

class HHEditTextState extends State<HHEditText> {
  TextEditingController controller = TextEditingController();

  void Function() param2;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      controller: controller,
      decoration: InputDecoration(
          errorText: widget.error ? widget.errorText : null,
          errorStyle: TextStyle(color: Color(0xffff8a73)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Color(0xffff8a73))),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.hint,
          errorBorder: errorOutlineInputBorder(),
          border: normalOutlineInputBorder()),
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
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}

OutlineInputBorder normalOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.grey),
  );
}

OutlineInputBorder errorOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Color(0xffff8a73)),
  );
}
