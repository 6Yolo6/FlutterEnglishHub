import 'package:flutter/material.dart';

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Writing Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Writing Page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}