import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class Expansionspanel extends StatefulWidget {
  Expansionpaneltate createState() => Expansionpaneltate();
}

class Expansionpaneltate extends State<Expansionspanel> {
  List<ExpansionpanelItem> items = <ExpansionpanelItem>[
    ExpansionpanelItem(
        color: HH_Colors.grey_585858,
        isExpanded: false,
        title: 'Header',
        content: Container(
          padding: EdgeInsets.all(20.0),
          child:               Column(children: <Widget>[
            Text('data'),
            Text('data'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ) //put the children here
          ])),

        leading: Icon(Icons.image)),
  ];

  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          items[index].isExpanded = !items[index].isExpanded;
        });
      },
      children: items.map((ExpansionpanelItem item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTileTheme(child:               ListTile(
              selectedTileColor: HH_Colors.color_D9D9D9,
                leading: item.leading,
                title: Text(
                  item.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ))
              ,
            tileColor: HH_Colors.color_D9D9D9,
            iconColor: HH_Colors.color_D9D9D9,);
          },
          isExpanded: item.isExpanded,
          body: item.content,
        );
      }).toList(),
    );
  }
}

class ExpansionpanelItem {
  bool isExpanded;
  final String title;
  final Widget content;
  final Icon leading;
  final Color color;

  ExpansionpanelItem({this.isExpanded, this.title, this.content, this.leading, this.color});
}
