import 'package:flutter/material.dart';

class SpokenPage extends StatefulWidget {
  @override
  _SpokenPageState createState() => _SpokenPageState();
}

class _SpokenPageState extends State<SpokenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spoken Page'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Spoken Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}