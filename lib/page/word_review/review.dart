import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/page/word_review/word_detail.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/controller/word_review_controller.dart';

class ReviewPage extends StatefulWidget {
  final int wordBookId;
  final int dailyNewWords;
  final int dailyReviewWords;

  const ReviewPage({
    Key? key,
    required this.wordBookId,
    required this.dailyNewWords,
    required this.dailyReviewWords,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late WordReviewController wordReviewController = Get.find<WordReviewController>();

  double topBarOpacity = 0.0;
  int currentWordIndex = 0;
  List<WordReview> words = [];
  bool showDefinition = false; // 控制释义显示
    late AudioPlayer _audioPlayer;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
        _audioPlayer = AudioPlayer();
    _fetchTodayWords();
    super.initState();
  }
  
  // 获取今日单词
  Future<void> _fetchTodayWords() async {
    words = await wordReviewController.fetchTodayWords(
      widget.wordBookId,
      widget.dailyNewWords,
      widget.dailyReviewWords,
    );
    setState(() {});
  }

  // 更新单词状态
  void _updateWordStatus(int status) async {
    if (currentWordIndex < words.length) {
      print('wordId: ${words[currentWordIndex].id}');
      print('wordBookId: ${widget.wordBookId}');
      print('status: $status');
      await wordReviewController.updateWordStatus(words[currentWordIndex].id, widget.wordBookId, status);
      setState(() {
        currentWordIndex++;
        showDefinition = false; // 重置释义显示
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('学习'),
        // 右侧图标，加入生词本
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // 添加到生词本
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          getAppBarView(),
          getReviewView(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget getReviewView() {
    if (words.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (currentWordIndex >= words.length) {
      return Center(child: Text('今日单词学习完成'));
    }

    final word = words[currentWordIndex];

    return ListView(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showDefinition = !showDefinition; // 切换释义显示
            });
          },
          child: WordCard(word: word, showDefinition: showDefinition),
        ),
        StatusView(
          onStatusSelected: (status) {
            _updateWordStatus(status);
          },
        ),
      ],
    );
  }

  Widget getAppBarView() {
    double progressValue = (words.isNotEmpty) ? currentWordIndex / words.length : 0.0;
    progressValue = progressValue.isNaN ? 0.0 : progressValue; // 确保值不为 NaN

    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animationController),
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - Tween<double>(begin: 0.0, end: 1.0).animate(animationController).value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Get.back();
                                }),
                            Expanded(
                              child: LinearProgressIndicator(
                                backgroundColor: Get.theme.colorScheme.shadow.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(Get.theme.colorScheme.secondary),
                                value: progressValue,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                showSettingsDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("学习设置"),
          content: const Text("Settings content goes here."),
          actions: <Widget>[
            TextButton(
              child: const Text('关闭'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}

class WordCard extends StatelessWidget {
  final WordReview word;
  final bool showDefinition;

  WordCard({Key? key, required this.word, required this.showDefinition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              word.word,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          word.phoneticUk!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          word.phoneticUs!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    ),
            if (showDefinition) ...[
              const SizedBox(height: 8),
              Text(
                word.definition,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Get.to(() => WordDetailPage(word: word));
              },
              child: Text('显示详细释义'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusView extends StatelessWidget {
  final Function(int) onStatusSelected;

  StatusView({Key? key, required this.onStatusSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  onStatusSelected(1); // 忘记
                },
              ),
              Text('忘记'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.blur_on),
                onPressed: () {
                  onStatusSelected(2); // 模糊
                },
              ),
              Text('模糊'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  onStatusSelected(3); // 认识
                },
              ),
              Text('认识'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.star),
                onPressed: () {
                  onStatusSelected(4); // 掌握
                },
              ),
              Text('掌握'),
            ],
          ),
        ],
      ),
    );
  }
}


