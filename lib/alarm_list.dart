import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmList extends StatefulWidget {
  final String title;

  const AlarmList({Key key, this.title}) : super(key: key);

  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("グループA"),

          ),
          Divider(thickness: 3,),
          ListTile(
            title: Text("グループB"),
          ),
          Divider(thickness: 3,),
          ListTile(
            title: Text("グループC"),
          ),
          Divider(thickness: 3,),
        ],
      ),
    );
  }
}
