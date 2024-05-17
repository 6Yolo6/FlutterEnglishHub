import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_english_hub/model/NewsHotwords.dart';

class HotwordDetailPage extends StatelessWidget {
  final NewsHotwords hotword;

  const HotwordDetailPage({Key? key, required this.hotword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotword.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(hotword.imageUrl),
              SizedBox(height: 8.0),
              Text(
                hotword.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                _parseContent(hotword.content),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _parseContent(String content) {
    // 将 JSON 字符串解析成中文和英文的双语内容
    List<dynamic> contentList = json.decode(content);
    StringBuffer parsedContent = StringBuffer();

    for (var item in contentList) {
      parsedContent.writeln(item.toString());
      parsedContent.writeln('\n');
    }

    return parsedContent.toString();
  }
}

