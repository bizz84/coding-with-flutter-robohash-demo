import 'package:flutter/material.dart';
import 'avatar.dart';

class AvatarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  static final formKey = new GlobalKey<FormState>();

  String _name = '';

  FocusNode _focusNode = new FocusNode();

  void _updateName(String name) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {});
      print('Saved: $_name');
    }
  }

  void _clear() {
    final form = formKey.currentState;
    form.reset();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      _buildInputForm(),
    ];
    if (_name.length > 0) {
      var url = 'https://robohash.org/$_name';
      var avatar = new Avatar(url: url, size: 150.0);
      children.addAll([
        new VerticalPadding(child: avatar),
        new VerticalPadding(child: new Text('Courtesy of robohash.org')),
      ]);
    }

    children.addAll([
      new Expanded(child: Container()),
      new Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        new VerticalPadding(
            child: new FlatButton(
          child: new Text('Clear', style: new TextStyle(fontSize: 24.0)),
          onPressed: _clear,
        ))
      ])
    ]);

    return new Scaffold(
      appBar: new AppBar(title: new Text('Greeting, Robot')),
      body: new Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: new Center(
          child: new Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    var children = [
      new VerticalPadding(
          child: new TextFormField(
        focusNode: _focusNode,
        decoration: new InputDecoration(
          labelText: 'Enter your unique identifier',
          labelStyle: new TextStyle(fontSize: 20.0),
        ),
        style: new TextStyle(fontSize: 24.0, color: Colors.black),
        validator: (val) => val.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (name) => _name = name,
        onFieldSubmitted: (name) => _updateName(name),
      ))
    ];

    return new Form(
      key: formKey,
      child: new Column(
        children: children,
      ),
    );
  }
}

class VerticalPadding extends StatelessWidget {
  VerticalPadding({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
