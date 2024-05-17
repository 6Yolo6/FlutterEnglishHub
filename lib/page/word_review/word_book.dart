import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/learning_plans_controller.dart';
import 'package:flutter_english_hub/controller/word_book_category_controller.dart';
import 'package:flutter_english_hub/controller/word_book_controller.dart';
import 'package:flutter_english_hub/model/WordBookCategory.dart';
import 'package:flutter_english_hub/model/WordBooks.dart';
import 'dart:math' as math;
import 'package:flutter_english_hub/page/widget/custom_image_painter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WordBookPage extends StatefulWidget {
  final int id;
  final int selectedNewCount;
  final int selectedReviewCount;

  const WordBookPage(
      {super.key,
      required this.id,
      required this.selectedNewCount,
      required this.selectedReviewCount});

  @override
  _WordBookPageState createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage>
    with TickerProviderStateMixin {
  late WordBookCategoryController wordBookCategoryController =
      Get.find<WordBookCategoryController>();
  late WordBookController wordBookController = Get.find<WordBookController>();

  // List<WordBookCategory> _categories = [];
  List<WordBookCategory> _categories = [WordBookCategory(id: 1, name: '分类1')];
  // 单词书列表
  List<WordBooks> _wordBooks = [];
  // 记录 TabBar 是否初始化
  bool isInitialized = false;
  // TabController
  late TabController _tabController;

  final List<String> _images = [
    'assets/images/word_book/1.jpg',
    'assets/images/word_book/2.jpg',
    'assets/images/word_book/3.jpg',
    'assets/images/word_book/4.jpg',
    'assets/images/word_book/5.jpg',
    'assets/images/word_book/6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _getCateData();
  }

  Future<void> _getCateData() async {
    var categories = await wordBookCategoryController.fetchWordBookCategory();
    if (categories.isNotEmpty) {
      if (mounted) {
        setState(() {
          _categories = categories;
          isInitialized = true;
          _tabController = TabController(vsync: this, length: _categories.length);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Books'),
        bottom: isInitialized
            ? TabBar(
                controller: _tabController,
                isScrollable: true, // 设置TabBar可以滚动
                tabs: _categories.map((c) => Tab(text: c.name)).toList(),
              )
            : null,
      ),
      body: isInitialized ? TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return FutureBuilder<List<WordBooks>>(
            future: wordBookController.getWordBooksByCategoryId(category.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error.toString()}'));
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(child: Text('No word books available'));
              } else { 
                _wordBooks = snapshot.data!;
                return buildWordBookList(category.id);
              }
            },
          );
        }).toList(),
      ) : Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildWordBookList(int categoryId) {
    return ListView.builder(
      itemCount: _wordBooks.length,
      itemBuilder: (context, index) {
        final imagePath = _images[math.Random().nextInt(_images.length)];
        final wordBook = _wordBooks[index];
        return WordBookTile(
          wordBookId: wordBook.id,
          selectedNewCount: widget.selectedNewCount,
          selectedReviewCount: widget.selectedReviewCount,
          bookName: wordBook.name,
          wordCount: wordBook.wordCount,
          imagePath: imagePath,
        );
      },
    );
  }
}

class WordBookList extends StatelessWidget {
  final List<WordBooks> wordBooks;
  final List<String> images;
  final int selectedNewCount;
  final int selectedReviewCount;

  WordBookList({
    required this.wordBooks,
    required this.images,
    required this.selectedNewCount,
    required this.selectedReviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wordBooks.length,
      itemBuilder: (context, index) {
        final imagePath = images[math.Random().nextInt(images.length)];
        final wordBook = wordBooks[index];

        return WordBookTile(
          wordBookId: wordBook.id,
          selectedNewCount: selectedNewCount,
          selectedReviewCount: selectedReviewCount,
          bookName: wordBook.name,
          wordCount: wordBook.wordCount,
          imagePath: imagePath,
        );
      },
    );
  }
}

class WordBookTile extends StatelessWidget {
  final int wordBookId;
  final int selectedNewCount;
  final int selectedReviewCount;
  final String bookName;
  final int wordCount;
  final String imagePath;

  WordBookTile({
    required this.bookName,
    required this.wordCount,
    required this.imagePath,
    required this.wordBookId,
    required this.selectedNewCount,
    required this.selectedReviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomImagePainter(bookName: bookName, imagePath: imagePath),
      title: Text(bookName),
      subtitle: Text('$wordCount words'),
      onTap: () {
        showDailyWordCountDialog(context, wordBookId, selectedNewCount,
            selectedReviewCount, wordCount);
      },
    );
  }
}

Future<void> showDailyWordCountDialog(BuildContext context, int wordBookId,
    int selectedNewCount, int selectedReviewCount, int totalWords) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('选择每日新学及复习单词数'),
        content: StatefulBuilder(
          // StatefulBuilder 用于在 Dialog 内部管理状态
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('每日新学单词数'),
                Slider(
                  value: selectedNewCount.toDouble(),
                  min: 10,
                  max: 100,
                  divisions: 9,
                  label: selectedNewCount.toString(),
                  onChanged: (double value) {
                    setState(() => selectedNewCount = value.toInt());
                  },
                ),
                Text('每日复习单词数'),
                Slider(
                  value: selectedReviewCount.toDouble(),
                  min: 10,
                  max: 100,
                  divisions: 9,
                  label: selectedReviewCount.toString(),
                  onChanged: (double value) {
                    setState(() => selectedReviewCount = value.toInt());
                  },
                ),
                Text(
                    '预计完成时间: ${calculateEstimatedCompletionDate(totalWords, selectedNewCount)}'),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('取消',
                style: TextStyle(
                  color: Get.theme.colorScheme.onPrimary,
                )),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('确定',
                style: TextStyle(
                  color: Get.theme.colorScheme.onPrimary,
                )),
            onPressed: () {
              // 计算预计完成时间
              String estimatedCompletionDate = calculateEstimatedCompletionDate(
                  totalWords, selectedNewCount);
              // 将数据和预计完成时间一起传给后端
              saveDailyCounts(wordBookId, selectedNewCount, selectedReviewCount,
                  estimatedCompletionDate);
            },
          ),
        ],
      );
    },
  );
}

String calculateEstimatedCompletionDate(int totalWords, int dailyNewCount) {
  int days = (totalWords / dailyNewCount).ceil();
  DateTime completionDate = DateTime.now().add(Duration(days: days));
  return "${completionDate.year}-${completionDate.month}-${completionDate.day}";
}

void saveDailyCounts(int wordBookId, int newCount, int reviewCount,
    String estimatedCompletionDate) {
  print(
      '单词书id: $wordBookId, 每日新学单词数: $newCount, 每日复习单词数: $reviewCount, 预计完成时间: $estimatedCompletionDate');

  // 调用后端接口保存数据
  late LearningPlansController learningPlansController =
      Get.find<LearningPlansController>();
  learningPlansController.saveOrUpdateLearningPlan(
      wordBookId, newCount, reviewCount, estimatedCompletionDate);
}
