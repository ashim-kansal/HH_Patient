import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/message.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  static const String RouteName = '/notification';

  NotificationPage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  final List<Message> _messages = <Message>[];
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);

    return new MyWidget(
      title: 'Notification',
        child: new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  //Chat list
                  new Flexible(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Dismissible(
                          key: Key(item),
                          onDismissed: (direction) {
                            setState(() {
                              items.removeAt(index);
                            });
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text("$item dismissed")));
                          },
                          // Show a red background as the item is swiped away.
                          background: Container(color: Colors.red),
                          child: ListTile(title: Text('$item')),
                        );
                      }
                    ),
                  ),
              
                ],
              ),
            )));
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}