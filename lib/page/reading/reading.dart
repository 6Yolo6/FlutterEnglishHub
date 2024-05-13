import 'package:flutter/material.dart';

import 'package:flutter_english_hub/page/reading/ebook_category.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 分类列表
  List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': '美文'},
    {'id': 2, 'name': '幽默'},
    {'id': 3, 'name': '诗歌'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
        bottom: TabBar(
          controller: _tabController,
          tabs: categories.map((category) {
            return Tab(text: category['name']);
          }).toList(),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: categories.map((category) {
              return EBookCategory(categoryId: category['id']);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

