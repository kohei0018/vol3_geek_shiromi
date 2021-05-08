import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlarmList extends StatefulWidget {
  final String title;
  final String user;

  const AlarmList({Key key, this.title, this.user}) : super(key: key);

  @override
  _AlarmListState createState() => _AlarmListState();
}



////////////////////////////////////API GET処理//////////////////////////
//network request
Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/3'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

//Albumクラス
class Album {
  final int userId;
  final int id;
  final String title;

  Album({@required this.userId, @required this.id, @required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
/////////////////////////////////////API GET処理////////////////////////


/////////////////////////////////////API POST処理////////////////////////

Future<Album2> createAlbum2(String title,user) async {
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'user': user
    }),
  );

  if (response.statusCode == 201) {
    return Album2.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album2 {
  final int id;
  final String title;
  final String user;

  Album2({this.id, this.title, this.user});

  factory Album2.fromJson(Map<String, dynamic> json) {
    return Album2(
      id: json['id'],
      title: json['title'],
      user: json['user']
    );
  }
}

/////////////////////////////////////API POST処理////////////////////////


enum Groups { A, B, C }
var groupId ;

class _AlarmListState extends State<AlarmList> {
  final TextEditingController _controller = TextEditingController();
  Future<Album> futureAlbum;
  Future<Album2> _futureAlbum2;
  @override

  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }
  var _radVal = Groups.A;
  void _onChanged(Groups value) {
    setState(() {
      _radVal = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          RadioListTile(
            title: Text("グループA"),
            value: Groups.A,
            groupValue: _radVal,
            onChanged: _onChanged
          ),
          Divider(thickness: 3,),
          RadioListTile(
            title: Text("グループB"),
              value: Groups.B,
              groupValue: _radVal,
              onChanged: _onChanged
          ),
          Divider(thickness: 3,),
          RadioListTile(
              title: Text("グループC"),
              value: Groups.C,
              groupValue: _radVal,
              onChanged: _onChanged
          ),
          Divider(thickness: 3,),
          Center(
            child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    print("データ取得完了");
                    print(snapshot.data.userId);
                    return Text(snapshot.data.title + ":" + snapshot.data.id.toString());
                  } else if (snapshot.hasError) {
                    print("データ取得失敗");
                    return Text("${snapshot.error}");
                  }
                  return ListTile(
                    title: Text("表示できるリストはありません"),
                  );
                }),
          ),
          Container(
            child: (_futureAlbum2 == null)
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
                    setState(() {
                      _futureAlbum2 = createAlbum2(_controller.text, widget.user);
                    });
                    },
                ),
                ElevatedButton(
                  child: Text("参加する"),
                  onPressed: () {
                    //グループの固有IDとuserをサーバーに送る
                    setState(() {
                      _futureAlbum2 = createAlbum2(_controller.text, widget.user);
                    });

                },)
              ],
            )
                : FutureBuilder<Album2>(
              future: _futureAlbum2,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.title + snapshot.data.user);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
                },
            ),

          ),
        ],
      ),
    );
  }
}
