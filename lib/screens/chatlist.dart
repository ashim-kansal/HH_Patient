import 'package:flutter/material.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/ChatUsers.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';
import 'package:simple_moment/simple_moment.dart';

class ChatListPage extends StatefulWidget {
  static const String RouteName = '/chat_users';

  ChatListPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget(title: AppLocalizations.of(context).mychat, child: Container(
      child: FutureBuilder<GetChatUsers>(
        future: getChatList(null, null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasError){
              return Container(
                child: Center(
                  child: HHTextView(title: AppLocalizations.of(context).no_msg, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,),
                ),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data.result.length,
              itemBuilder: (context, index) {
                var item = snapshot.data.result[index];
                var _date = item.message[item.message.length - 1].createdAt;
                Moment createdDt = Moment.parse('$_date');
                return ChatUserCell(
                  name: item.receiverId ==null ?"":item.receiverId.firstName+" "+item.receiverId.lastName,
                  message: item.message[item.message.length - 1].message,
                  profile: item.receiverId == null ? '':item.receiverId.profilePic,
                  time: createdDt.format("hh:mm a"),
                  online: true,
                  onClick: () {
                    Navigator.pushNamed(context, ChatPage.RouteName, arguments: ChatArguments(item.receiverId.id));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    ));
  }
}
