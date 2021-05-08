import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

////////////////////API POST処理///////////////////////

Future<Album> createAlbum(String title, user) async {
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'user' :user,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;
  final user;

  Album({this.id, this.title, this.user});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      user: json['user']
    );
  }
}

////////////////////API POST処理///////////////////////



class CreateGroup extends StatefulWidget {
  final String title;
  final String user;

  const CreateGroup({Key key, this.title, this.user}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}



class _CreateGroupState extends State<CreateGroup> {

  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  String id;
  String setTime;
  String _time='';

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 30),
      _onTimer,
    );
    super.initState();
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    var formattedTime = formatter.format(now);
    setState(() => _time = formattedTime);
    print(_time);
  }

  @override
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
                setTime = text;
                print("Time: $setTime");
              },
            ),
            Container(
              child: (_futureAlbum == null)
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter Title'),
                  ),
                  ElevatedButton(
                    child: Text('Create Data'),
                    onPressed: () {
                      print(widget.user);
                      setState(() {
                        _futureAlbum = createAlbum(_controller.text, widget.user);
                      });
                    },
                  ),
                ],
              )
                  : FutureBuilder<Album>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('ユーザー名：' + snapshot.data.user + "    設定時間：" + snapshot.data.title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
            ),
            // RaisedButton(
            //   child: Text("作成する"),
            //   onPressed: () {
            //     print("user : $widget.user");
            //     print("setTime : $setTime");
            //   },
            // ),
          ],
        ),
      ),

    );
  }

}
