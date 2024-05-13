import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/word_book_controller.dart';
import 'package:flutter_english_hub/page/drawer/forgetting_curve_screen.dart';
import 'package:flutter_english_hub/page/widget/title_view.dart';
import 'package:flutter_english_hub/model/WordBook.dart';
import 'package:flutter_english_hub/page/word_review/word_book_view.dart';
import 'package:flutter_english_hub/page/word_review/word_list.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:get/get.dart'; // 用于状态管理和路由

class WordReviewPage extends StatefulWidget {
  const WordReviewPage({super.key, this.animationController});

  final AnimationController? animationController;

  @override
  _WordReviewPageState createState() => _WordReviewPageState();
}

class _WordReviewPageState extends State<WordReviewPage> {
  double topBarOpacity = 0.0;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  String selectedBook = "Word Book Title"; // Placeholder for book title
  late Future<WordBook> wordBook;
  late WordBookController wordBookController = Get.find<WordBookController>();

  // 单词书对象(模拟数据)
  // final WordBook wordBook =
  //     WordBook(54, 'CET 4 考前急救词包', 12, 30, 1507, 2000, 250, 58, 90);

  @override
  void initState() {
    // addAllListData();

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

  void addAllListData(WordBook wordBook) {
    const int count = 4;
    // 顶部标题视图
    listViews.add(
      TitleView(
        titleTxt: '今日还未打卡',
        subTxt: '详情',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    // 单词书视图
    listViews.add(
      WordBookView(
        wordBook: wordBook,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    // 单词书选项卡视图
    listViews.add(
      WordBookScreen(
        wordBookId: wordBook.id,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<WordBook> fetchWordBook() async {
    return wordBookController.fetchWordBook();
  }

  Widget getReviewListView() {
    return FutureBuilder<WordBook>(
      future: fetchWordBook(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 加载中
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // 错误处理
        } else {
          WordBook wordBook = snapshot.data!;
          listViews = []; // 清空列表
          addAllListData(wordBook); // 使用WordBook对象添加数据
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
            getReviewListView(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}

class WordBookScreen extends StatelessWidget {

  final int wordBookId;

  const WordBookScreen({
    super.key,
    required this.animationController,
    required this.animation, required this.wordBookId,
  });

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 使用 Transform 来实现标题的动画效果
              Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation!.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 5.0, bottom: 10),
                  child: Text(
                    '学习进度',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // 使用 Transform 来实现卡片的动画效果
              Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation!.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 20),
                  child: Container(
                    // 卡片背景颜色、圆角、阴影
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    // 单词书的选项卡
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Get.to(() => WordListPage(
                              wordBookId: wordBookId,
                            ), transition: Transition.fade, duration: Duration(seconds: 1));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.list_alt_outlined),
                            title: Text('单词列表'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // 在这里处理点击事件
                            Get.to(() => ForgettingCurveScreen(), transition: Transition.fade, duration: Duration(seconds: 1));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.bar_chart_outlined),
                            title: Text('进度统计'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // 在这里处理点击事件
                          },
                          child: const ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('学习设置'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
