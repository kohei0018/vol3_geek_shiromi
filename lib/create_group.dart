import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  final String title;
  final String user;

  const CreateGroup({Key key, this.title, this.user}) : super(key: key);


  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override

  String id;
  String time;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("グループ作成"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            //ユーザー名出力
            Container(
              child: Text("ユーザー名 :" + (widget.user)),
            ),

            //設定時間入力
            TextField(
              decoration: InputDecoration(
                  hintText: "設定時間を入力してください (例)8:30"
              ),
              onChanged: (text) {
                print("Time: $time");
                time = text;
              },
            ),
            RaisedButton(
              child: Text("作成する"),
              onPressed: () {
                print("user : $widget.user");
                print("time : $time");
              },
            ),
          ],
        ),
      ),

    );
  }
}
