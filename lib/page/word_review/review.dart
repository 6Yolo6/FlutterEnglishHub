import 'package:flutter/material.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:get/get.dart';

class ReviewPage extends StatefulWidget {
  final AnimationController? animationController;
  // 单词书ID
  final int wordBookId;

  const ReviewPage(
      {Key? key, this.animationController, required this.wordBookId});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;

  // 当前单词索引
  int currentWordIndex = 0;

  // 单词及音标，释义对象列表
  List<Word> words = [
    Word('abrupt', '[əˈbrʌpt]', '突然的'),
    Word('absurd', '[əbˈsɜːrd]', '荒谬的'),
    Word('abundant', '[əˈbʌndənt]', '丰富的'),
    Word('accessible', '[əkˈsesəbl]', '可接近的'),
  ];

  // 手势识别
  void onSwipe(Direction direction) {
    setState(() {
      // Update the word status based on the direction of the swipe
      // And load the next word
    });
  }

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // 初始化动画控制器
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    // 监听滚动事件，实现顶部导航栏渐变
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
  }

  void addAllListData() {
    const int count = 4;

    // 背单词主体卡片视图
    listViews.add(
      WordView(
        word: words[currentWordIndex],
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    // 底部4个背单词状态视图
    listViews.add(
      StatusView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
  }

  Future<bool> getData() async {
    // 用于获取今日要背的单词数据，这里还未实现，暂时模拟延迟
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('学习'),
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
      ),
    );
  }

  // 背单词主体视图
  Widget getReviewView() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  // 顶部返回按钮、背单词进度视图
  Widget getAppBarView() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
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
                            // 返回按钮
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  // 返回上一页
                                  Get.back();
                                }),
                            // 学习的单词进度条
                            Expanded(
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                value: currentWordIndex / words.length,
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
                // 关闭对话框
                // Navigator.of(context).pop();
                // get的弹窗关闭方法
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}

class Word {
  final String word;
  final String phonetic;
  final String definition;

  Word(this.word, this.phonetic, this.definition);
}

class StatusView extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController animationController;

  const StatusView(
      {Key? key, required this.animation, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 10, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    // 单词状态ui，忘记，模糊，认识，掌握，且分别有图标
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            // 忘记
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.blur_on),
                          onPressed: () {
                            // 模糊
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            // 认识
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            // 掌握
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WordView extends StatelessWidget {
  final Word word;
  final Animation<double> animation;
  final AnimationController animationController;

  const WordView(
      {Key? key,
      required this.word,
      required this.animation,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform:
            Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 居中显示单词，换行显示音标，换行显示释义
                Center(
                  child: Text(
                    word.word,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    word.phonetic,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    word.definition,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Direction { left, right, up, down }

class WordCard extends StatelessWidget {
  // Add your word data parameters

  WordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build your word card UI
    return const Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('abrupt'), // Replace with your data
          // Add phonetics, meaning, example, etc.
        ],
      ),
    );
  }
}
