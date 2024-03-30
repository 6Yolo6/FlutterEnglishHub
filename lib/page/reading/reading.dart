import 'package:flutter/material.dart';

class ReadingPage extends StatefulWidget {
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Page'),
      ),
      body: Container(
        child: Center(
          child: Text('Reading Page Content'),
        ),
      ),
    );
  }
}