import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

class ChatListPage extends StatefulWidget {
  static const String RouteName = '/chat_users';
  final users = [
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
  ];

  ChatListPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Chat', style: TextStyle(color: Colors.white)),
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
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: ListView.separated(
                itemCount: widget.users.length,
                itemBuilder: (context, index) {
                  return ChatUserCell(
                    name: widget.users[index],
                    online: true,
                    onClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ChatPage.RouteName);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            )));
  }
}
