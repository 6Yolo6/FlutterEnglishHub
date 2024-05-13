import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomLanguagePage extends StatefulWidget {
  @override
  _CustomLanguagePageState createState() => _CustomLanguagePageState();
}

class _CustomLanguagePageState extends State<CustomLanguagePage> {
  final List<Locale> languages = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择语言'),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(languages[index].languageCode),
            onTap: () {
              setState(() {
                Get.updateLocale(languages[index]);
              });
            },
          );
        },
      ),
    );
  }
}