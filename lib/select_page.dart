import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/stop_alarm.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'alarm_list.dart';
import 'create_group.dart';

class SelectPage extends StatefulWidget {
  final String user;

  const SelectPage({Key key, this.user}) : super(key: key);


  @override
  _CreateSelectPage createState() => _CreateSelectPage();
}

class _CreateSelectPage extends State<SelectPage> {
  @override

  List<String> titleList = ["グループ作成","アラームのリスト","アラーム停止"];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("選択画面"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(titleList[0]),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateGroup(
              title: titleList[0],
              user: widget.user,
            ))
            ),
          ),
          Divider(thickness: 3,),


          ListTile(
            title: Text(titleList[1]),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AlarmList(
              title: titleList[1],
            ))
            ),
          ),
          Divider(thickness: 3),


          ListTile(
            title: Text(titleList[2]),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => StopAlarm(
              title: titleList[2],
            ))
            ),
          ),
          Divider(thickness: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ボタンが押されたときの処理
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification, // Android用のサウンド
            ios: const IosSound(1023), // iOS用のサウンド
            //looping: true, // Androidのみ。ストップするまで繰り返す
            asAlarm: true, // Androidのみ。サイレントモードでも音を鳴らす
            volume: 1.0, // Androidのみ。0.0〜1.0
          );
          // FlutterRingtonePlayer.playAlarm();
          // FlutterRingtonePlayer.playRingtone();

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
