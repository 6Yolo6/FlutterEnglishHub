import 'package:flutter_english_hub/page/widget/success_timeline.dart';
import 'package:flutter/material.dart';


class DailySentenceList extends StatefulWidget {
  const DailySentenceList({super.key});

  @override
  _DailySentenceListState createState() => _DailySentenceListState();
}

class _DailySentenceListState extends State<DailySentenceList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('每日一句'),
        centerTitle: true,
        // 右侧搜索按钮
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 搜索每日一句
              print("搜索每日一句");
            },
          ),
        ],
      ),
      body: SuccessTimeline(),
    );
  }
}


