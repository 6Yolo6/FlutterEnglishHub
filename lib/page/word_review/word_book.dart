import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_english_hub/page/widget/custom_image_painter.dart';
import 'package:get/get.dart';


class WordBookPage extends StatefulWidget {
  const WordBookPage({super.key});

  @override
  _WordBookPageState createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = ['四级', '六级', '考研']; // 分类标签

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('添加单词本'),
          bottom: TabBar(
            controller: _tabController,
            tabs: _categories.map((String category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _categories.map((String category) {
            return buildWordBookList(category);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildWordBookList(String category) {
    // Sample word count for each category
    final wordCount = math.Random().nextInt(1000) + 100;

    return ListView.builder(
      itemCount: 10, // Replace with your actual item count
      itemBuilder: (context, index) {
        final bookName = '$category 单词书 $index'; // Example book name
        const imagePath = 'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg';

        return WordBookTile(
          bookName: bookName,
          wordCount: wordCount.toString(),
          imagePath: imagePath,
        );
      },
    );
  }
}

class WordBookTile extends StatelessWidget {
  final String bookName;
  final String wordCount;
  final String imagePath;

  WordBookTile({
    required this.bookName,
    required this.wordCount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: CustomImagePainter(bookName: bookName, imagePath: 'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg'),
        child: SizedBox(width: 50, height: 50),
      ),
      title: Text(bookName),
      subtitle: Text('$wordCount words'),
      onTap: () {
        showDailyWordCountDialog(context, int.parse(wordCount));
      },
    );
  }
}



Future<void> showDailyWordCountDialog(BuildContext context, int totalWords) async {
  int selectedCount = 20; // 默认选中的每日单词数
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('选择每日学习次数'),
        content: StatefulBuilder(  // StatefulBuilder 用于在 Dialog 内部管理状态
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: selectedCount.toDouble(),
                  min: 10,
                  max: 100,
                  divisions: 9,
                  label: selectedCount.toString(),
                  onChanged: (double value) {
                    setState(() => selectedCount = value.toInt());
                  },
                ),
                Text('预计完成时间: ${calculateEstimatedCompletionDate(totalWords, selectedCount)}'),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              '取消',
              style: TextStyle(
                color: Get.theme.colorScheme.onPrimary,
              )
            ),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('确定',
              style: TextStyle(
                color: Get.theme.colorScheme.onPrimary,
              )),
            onPressed: () {
              // TODO: 确定选项，保存学习计划
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String calculateEstimatedCompletionDate(int totalWords, int dailyCount) {
  int days = (totalWords / dailyCount).ceil();
  DateTime completionDate = DateTime.now().add(Duration(days: days));
  return "${completionDate.year}-${completionDate.month}-${completionDate.day}";
}