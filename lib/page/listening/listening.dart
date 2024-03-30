import 'package:flutter/material.dart';

class ListeningPage extends StatefulWidget {
  @override
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Page'),
      ),
      body: Center(
        child: Text('Listening Page Content'),
      ),
    );
  }
}