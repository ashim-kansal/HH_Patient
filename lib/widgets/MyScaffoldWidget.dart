import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget{

  var title= "";
  double sideMargin=20;
  Widget child;
  bool showFloatingButton = false;
  VoidCallback onClickFAB;

  MyWidget({Key key, @required this.title, @required this.child, this.sideMargin, this.showFloatingButton, this.onClickFAB});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(color: Colors.white)),
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
              width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(sideMargin??20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    color: Colors.white),
                child: child

              // backgroundColor: Colors.white,
              // This trailing comma makes auto-formatting nicer for build methods.
            )),
        floatingActionButton: new Visibility(
          visible: (showFloatingButton==null || !showFloatingButton )? false:true,
          child: new FloatingActionButton(child: new Icon(Icons.add),
            onPressed: (){
              onClickFAB();
            },
          ),
    ),
    );

  }
}

class MyStateWidget extends StatefulWidget {

  var title= "";
  double sideMargin=20;
  Widget child;
  bool showFloatingButton = false;
  MyStateWidget({Key key, @required this.title, @required this.child, this.sideMargin, this.showFloatingButton}) : super(key: key);

  var error = false;

  @override
  _MyStateFullWidget createState() => _MyStateFullWidget();
}

class _MyStateFullWidget extends State<MyStateWidget>{

  @override
  void dispose() {
    super.dispose();
  }
  // MyStateFullWidget({Key key, @required this.title, @required this.child, this.sideMargin, this.showFloatingButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
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
              width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(widget.sideMargin??20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    color: Colors.white),
                child: widget.child

              // backgroundColor: Colors.white,
              // This trailing comma makes auto-formatting nicer for build methods.
            )),
        floatingActionButton: new Visibility(
          visible: (widget.showFloatingButton==null || !widget.showFloatingButton )? false:true,
          child: new FloatingActionButton(child: new Icon(Icons.add),
          ),
    ),
    );

  }
}