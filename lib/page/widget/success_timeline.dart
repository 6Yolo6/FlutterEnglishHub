import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/daily_sentence_controller.dart';
import 'package:flutter_english_hub/model/DailySentence.dart';
import 'package:flutter_english_hub/page/daily_sentence/daily_sentence_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:math';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SuccessTimeline extends StatefulWidget {
  @override
  SuccessTimelineState createState() => SuccessTimelineState();
}

class SuccessTimelineState extends State<SuccessTimeline> {
  Future<void>? _initFuture;
  late List<DailySentence> dailySentences;
  final DailySentenceController dailySentenceController =
      Get.find<DailySentenceController>();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _initFuture = _generateData();
    super.initState();
    // _scrollController.addListener(_onScroll);
  }

  void _onRefresh() async {
    // 更新数据，重新获取第一页数据
    dailySentences = await dailySentenceController.refreshDailySentences();
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // 添加更多数据
    dailySentences.addAll(await dailySentenceController.fetchDailySentences());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  // Future<void> _onScroll() async {
  //   if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
  //     // 获取下一页数据
  //     var newSentences = await dailySentenceController.fetchDailySentences();
  //     setState(() {
  //       dailySentences.addAll(newSentences);
  //     });
  //   }
  // }

  @override
  void dispose() {
    // _scrollController.removeListener(_onScroll);
    // _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // 显示一个进度指示器
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // 显示错误信息
          } else {
            // Future 已完成，显示实际的界面
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFCCCA9), Color(0xFFFFA578)],
                  // colors: [Get.theme.primaryColor, Get.theme.colorScheme.secondary],
                ),
              ),
              child: SafeArea(
                child: Scaffold(
                  // backgroundColor: Colors.transparent,
                  backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
                  body: Center(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          // 使用 SmartRefresher 包裹 CustomScrollView
                          child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: WaterDropMaterialHeader(),
                            footer: CustomFooter(
                              builder:
                                  (BuildContext context, LoadStatus? mode) {
                                Widget body;
                                if (mode == LoadStatus.idle) {
                                  body = Text("pull up load");
                                } else if (mode == LoadStatus.loading) {
                                  body = CircularProgressIndicator(
                                    // 设置加载指示器颜色
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Get.theme.colorScheme.onPrimary),
                                  );
                                } else if (mode == LoadStatus.failed) {
                                  body = Text("Load Failed!Click retry!");
                                } else if (mode == LoadStatus.canLoading) {
                                  body = Text("release to load more");
                                } else {
                                  body = Text("No more Data");
                                }
                                return Container(
                                  height: 55.0,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            onLoading: _onLoading,
                            child: CustomScrollView(
                              // controller: _scrollController,
                              slivers: <Widget>[
                                _TimelineSteps(dailySentences: dailySentences),
                                // Obx(() => _TimelineSteps(dailySentences: dailySentenceController.dailySentences)),
                              ],
                            ),
                          ),
                          // child: CustomScrollView(
                          //   controller: _scrollController,
                          //   slivers: <Widget>[
                          //     _TimelineSteps(dailySentences: dailySentences),
                          //     // Obx(() => _TimelineSteps(dailySentences: dailySentenceController.dailySentences)),
                          //   ],
                          // ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

  Future<void> _generateData() async {
    // return [
    //   DailySentence(
        // content: 'I wish I could be more like you.',
        // translation: '我要像你一样就好了。',
        // imagePath:
        //     'https://staticedu-wps.cache.iciba.com/image/de2e69c3d4b01ce2748e5d4f72dc96bd.png',
        // audioPath:
        //     'https://staticedu-wps.cache.iciba.com/audio/626c081f5f418b3e44e044c54e5e195a.mp3',
        // date: DateTime.parse('2024-05-08 00:00:00'),
    //   ),
    //   DailySentence(
    //     content: 'Whatever comes, I\'ll love you, just as I do now. Until I die.',
    //     translation: '无论发生什么事，我都会像现在一样爱你，直到永远。',
    //     imagePath:
    //         'https://staticedu-wps.cache.iciba.com/image/1473f3b6362aeb10c26afa1acfefb966.png',
    //     audioPath:
    //         'https://staticedu-wps.cache.iciba.com/audio/626c081f5f418b3e44e044c54e5e195a.mp3',
    //     date: DateTime.parse('2024-05-09 00:00:00'),
    //   ),
    //   DailySentence(
    //     content: 'There is always a better way.',
    //     translation: '总有更好的办法。',
    //     imagePath:
    //         'https://staticedu-wps.cache.iciba.com/image/49699fd1a13a4ef514c825cae9813338.png',
    //     audioPath:
    //         'https://staticedu-wps.cache.iciba.com/audio/432f4b9532164db43103fbeafe692048.mp3',
    //     date: DateTime.parse('2024-05-10 00:00:00'),
    //   ),
    // ];
    dailySentences = await dailySentenceController.refreshDailySentences();
    // dailySentenceController.fetchDailySentences();
  }
}

class _TimelineSteps extends StatelessWidget {
  // final RxList<DailySentence> dailySentences;
  final List<DailySentence> dailySentences;

  const _TimelineSteps({Key? key, required this.dailySentences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd)
            return TimelineDivider(
              color: Color(0xFFCB8421),
              // color: Get.theme.primaryColor,
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );

          final int itemIndex = index ~/ 2;
          final DailySentence dailySentence = dailySentences[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            // id: dailySentence.id,
            // content: dailySentence.content,
            // translation: dailySentence.translation,
            isLeftAlign: isLeftAlign,
            dailySentence: dailySentence,
            // imagePath: dailySentence.imagePath,
            // audioPath: dailySentence.audioPath,
            // date: dailySentence.date,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == dailySentences.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.1 : 0.9,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicatorXY: indicatorY,
              indicator: _TimelineStepIndicator(
                  date: DateFormat('dd').format(dailySentence.date)),
            ),
            beforeLineStyle: LineStyle(
              color: Color(0xFFCB8421),
              // color: Get.theme.primaryColor,
              thickness: 5,
            ),
          );
        },
        childCount: max(0, dailySentences.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  const _TimelineStepIndicator({Key? key, required this.date})
      : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFCB8421),
      ),
      child: Center(
        child: Text(
          date,
          style: GoogleFonts.architectsDaughter(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TimelineStepsChild extends StatelessWidget {
  // final String content;
  // final String translation;
  final bool isLeftAlign;
  // final String imagePath;
  // final String audioPath;
  // final DateTime date;
  // final int id;
  final DailySentence dailySentence;

  const _TimelineStepsChild({
    Key? key,
    // required this.content,
    // required this.translation,
    required this.isLeftAlign, 
    required this.dailySentence,
    // required this.imagePath,
    // required this.audioPath,
    // required this.date, 
    // required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            () => DailySentenceDetailPage(
                // sentenceId: id,
                detail: dailySentence
                ),
            transition: Transition.fade,
            duration: Duration(seconds: 1));
      },
      child: Padding(
        padding: isLeftAlign
            ? const EdgeInsets.only(right: 32, top: 16, bottom: 16, left: 10)
            : const EdgeInsets.only(left: 32, top: 16, bottom: 16, right: 10),
        child: Column(
          crossAxisAlignment:
              isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // 显示日期
            Text(
              DateFormat('yyyy MMM dd').format(dailySentence.date),
              style: GoogleFonts.acme(
                fontSize: 20,
                color: const Color(0xFFB96320),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // 显示每日一句
            Text(
              dailySentence.content,
              style: GoogleFonts.acme(
                fontSize: 18,
                color: const Color(0xFFB96320),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // 显示翻译
            Text(
              dailySentence.translation,
              style: GoogleFonts.architectsDaughter(
                fontSize: 16,
                color: const Color(0xFFB96320),
              ),
            ),
            SizedBox(height: 16),
            // 显示图片
            dailySentence.imagePath.isNotEmpty
                ? Container(
                    width: 350,
                    height: 350,
                    child: Image.network(dailySentence.imagePath,
                        // 保持原始的宽高比
                        fit: BoxFit.scaleDown),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Seven steps to success!',
              textAlign: TextAlign.center,
              style: GoogleFonts.architectsDaughter(
                fontSize: 26,
                color: const Color(0xFFB96320),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
