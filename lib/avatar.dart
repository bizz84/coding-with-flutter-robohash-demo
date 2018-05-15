import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Avatar extends StatefulWidget {
  Avatar({this.url, this.size});
  final String url;
  final double size;
  @override
  State<StatefulWidget> createState() => new _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Future<Uint8List> fetchAvatar() async {
    http.Response response = await http.get(widget.url);
    return response.bodyBytes;
  }

  Widget loadingWidget() {
    return new FutureBuilder<Uint8List>(
      future: fetchAvatar(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Image.memory(snapshot.data);
        } else if (snapshot.hasError) {
          print('${snapshot.error}');
          return new Center(
              child: new Text('❌', style: TextStyle(fontSize: 72.0)));
        } else {
          return new Container(
            padding: EdgeInsets.all((widget.size - 50.0) / 2.0),
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: widget.size,
      height: widget.size,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: Colors.blue,
            width: 3.0,
          ),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black12,
              ])),
      child: new ClipOval(
        child: loadingWidget(),
      ),
    );
  }
}
