import 'package:flutter/material.dart';
import 'package:flutter_english_hub/main.dart';
import 'package:flutter_english_hub/model/WordBook.dart';
import 'package:flutter_english_hub/page/word_review/review.dart';
import 'package:flutter_english_hub/page/word_review/vocabulary_book.dart';
import 'dart:math' as math;
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class VocabularyView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final WordBook wordBook;

  const VocabularyView({super.key, this.animationController, this.animation, required this.wordBook});

  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('学习'),
    //   ),
    //   body: ListView(
    //     children: [
    //       Card(
    //         margin: EdgeInsets.all(8.0),
    //         child: ListTile(
    //           leading: Image.network(
    //             'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg', // Replace with your custom image URL
    //             width: 50,
    //             height: 50,
    //           ),
    //           title: Text(selectedBook),
    //           subtitle: Text('$learnedWords / $totalWords words'),
    //           trailing: const Text('更换'),
    //           onTap: () {
    //             // 跳转到单词书选择页面
    //             Get.to(const VocabularyBookPage(),transition: Transition.rightToLeft, duration: Duration(milliseconds: 500));
    //           },
    //         ),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.settings),
    //         title: Text('Vocabulary book settings'),
    //         onTap: () {
    //           //
    //
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.sync),
    //         title: Text('Synchronization settings'),
    //         onTap: () {
    //           //
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.bar_chart),
    //         title: Text('Learning statistics'),
    //         onTap: () {
    //           //
    //         },
    //       ),
    //     ],
    //   ),
    // );

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
                  left: 20, right: 20, top: 5, bottom: 20),
              child: Container(
                // 卡片背景颜色、圆角、阴影
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          // 单词书名称、封面、开始学习按钮
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 0),
                              child: Column(
                                children: <Widget>[
                                  // 顶部单词书名称和更换按钮
                                  Row(
                                    // 主轴居中
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // 左侧边距
                                      const Padding(
                                          padding: EdgeInsets.only(left: 5)
                                      ),
                                      // 单词书名称
                                      SizedBox(
                                        width: 130,
                                        height: 30,
                                        child: Marquee(
                                          text: wordBook.name,
                                          style: const TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            letterSpacing: 0.5,
                                            color: AppTheme.darkText,
                                          ),
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          blankSpace: 50.0,
                                          velocity: 50.0, // 50 px/s滚动速度
                                          pauseAfterRound: const Duration(seconds: 1),
                                          startPadding: 10.0,
                                          accelerationDuration: const Duration(seconds: 1),
                                          accelerationCurve: Curves.linear,
                                          decelerationDuration: const Duration(milliseconds: 1000),
                                          decelerationCurve: Curves.easeOut,
                                        ),
                                      ),
                                      // 更换单词书
                                      Align(
                                        alignment: Alignment.topRight, // 右上角对齐
                                        child: TextButton(
                                          onPressed: () {
                                            // 跳转到单词书选择页面
                                            Get.to(const VocabularyBookPage(),
                                                transition: Transition.rightToLeft,
                                                duration: const Duration(milliseconds: 500));
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: AppTheme.white, // 按钮背景颜色
                                            padding: EdgeInsets.zero, // 设置内边距为0
                                            minimumSize: const Size(40, 20), // 按钮最小大小
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // 按钮圆角
                                              side: const BorderSide(
                                                color: AppTheme.lightText, // 边框颜色
                                                width: 1, // 边框宽度
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            '更换',
                                            style: TextStyle(
                                              color: AppTheme.lightText, // 文字颜色
                                              fontSize: 14, // 文字大小
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  // 单词书封面及开始学习按钮
                                  Row(
                                    children: <Widget>[
                                      // 封面左侧的竖线
                                      Container(
                                        height: 70,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: AppTheme.lightBlue
                                              .withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                      // 封面图片
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, left: 8),
                                        // 图片自适应大小
                                        child: SizedBox(
                                          width: 70,
                                          height: 90,
                                          child: Image.asset(
                                            'assets/images/word_book/1.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // 开始学习按钮
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            // 开始学习
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: TextButton(
                                                onPressed: () {
                                                  // 跳转到单词学习页面
                                                  Get.to(
                                                      () => ReviewPage(
                                                          wordBookId: wordBook.id,
                                                          animationController:
                                                              animationController!),
                                                      transition:
                                                          Transition.fade,
                                                      duration: const Duration(
                                                          milliseconds: 800));
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppTheme.lightBlue,
                                                  // 按钮背景颜色
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  // 设置内边距
                                                  minimumSize:
                                                      const Size(40, 20),
                                                  // 按钮最小大小
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20), // 按钮圆角
                                                  ),
                                                ),
                                                child: const Text(
                                                  '开始学习',
                                                  style: TextStyle(
                                                    color: AppTheme.white,
                                                    // 文字颜色
                                                    fontSize: 14, // 文字大小
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 单词书学习进度
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       AnimatedBuilder(
                          //         animation: animationController!,
                          //         builder: (BuildContext context, Widget? child) {
                          //           return CustomPaint(
                          //             size: const Size(100, 100),
                          //             painter: ProgressPainter(
                          //               learned: (animation!.value * wordBook.learnedWords).round(),
                          //               total: wordBook.totalWords,
                          //               progressColor: Colors.blue,
                          //               backgroundColor: Colors.grey.withAlpha(88),
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10 ),
                            child: Column(
                              children: <Widget>[
                                CustomPaint(
                                  size: const Size(100, 100), // You can change this as needed
                                  painter: ProgressPainter(
                                    learned: (animation!.value * wordBook.learnedWords).round(),
                                    total: wordBook.totalWords,
                                    progressColor: AppTheme.lightBlue,
                                    backgroundColor: AppTheme.grey.withAlpha(88),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 分割线
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    // 待学，已掌握，剩余天数
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          // 待学单词数
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // 待学
                                const Text(
                                  '今日待学',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.2,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                                // 进度条
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  // 进度条长度70
                                  child: Container(
                                    height: 4,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          HexColor('#87A0E5').withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        // LayoutBuilder(
                                        //   builder: (context, constraints) {

                                            // double fractionLearned =
                                            //     wordBook.learnedToday /
                                            //         wordBook.toLearnToday;
                                        // 计算今日学习进度，animation.value为动画进度：0-1动态变化
                                        Container(
                                          width: 70 *
                                              animation!.value *
                                              wordBook.learnedToday /
                                              wordBook.toLearnToday,
                                          // 进度条宽度
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#87A0E5'),
                                              HexColor('#87A0E5')
                                                  .withOpacity(0.5),
                                            ]),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4.0)),
                                          ),
                                        ),
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                // 今日剩余单词数
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    '${wordBook.toLearnToday - wordBook.learnedToday} left today',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                // // 进度条
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 4),
                                //   child: Container(
                                //     height: 4,
                                //     width: 70,
                                //     decoration: BoxDecoration(
                                //       color:
                                //       HexColor('#87A0E5').withOpacity(0.2),
                                //       borderRadius: const BorderRadius.all(
                                //           Radius.circular(4.0)),
                                //     ),
                                //     child: Row(
                                //       children: <Widget>[
                                //         Container(
                                //           width: ((70 / 1.2) * animation!.value),
                                //           height: 4,
                                //           decoration: BoxDecoration(
                                //             gradient: LinearGradient(colors: [
                                //               HexColor('#87A0E5'),
                                //               HexColor('#87A0E5')
                                //                   .withOpacity(0.5),
                                //             ]),
                                //             borderRadius: const BorderRadius.all(
                                //                 Radius.circular(4.0)),
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // // 今日剩余单词数
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 6),
                                //   child: Text(
                                //     '${wordBook.toLearnToday} - ${wordBook.learnedToday}',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       fontFamily: AppTheme.fontName2,
                                //       fontWeight: FontWeight.w600,
                                //       fontSize: 12,
                                //       color:
                                //       AppTheme.grey.withOpacity(0.5),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // 已掌握单词数
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 已掌握
                                    const Text(
                                      '已掌握',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: -0.2,
                                        color: AppTheme.darkText,
                                      ),
                                    ),
                                    // 进度条
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F56E98')
                                              .withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            // LayoutBuilder(
                                            //   builder: (context, constraints) {
                                                // 计算比例
                                                // double fractionMastered =
                                                //     wordBook.masterWords /
                                                //         wordBook.totalWords;
                                            Container(
                                                  width: 70 * animation!.value * wordBook.masterWords /
                                          wordBook.totalWords,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      HexColor('#F56E98')
                                                          .withOpacity(0.1),
                                                      HexColor('#F56E98'),
                                                    ]),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                ),
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 数量
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${wordBook.masterWords} mastered',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // 剩余天数
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 剩余天数
                                    const Text(
                                      '剩余天数',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: -0.2,
                                        color: AppTheme.darkText,
                                      ),
                                    ),
                                    // 进度条
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F1B440')
                                              .withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            // LayoutBuilder(
                                            //   builder: (context, constraints) {
                                                // 计算天数比例
                                                // double fractionLearned =
                                                //     wordBook.learnedDays /
                                                //         wordBook.totalDays;
                                                Container(
                                                  width: 70 * animation!.value * wordBook.learnedDays /
                                          wordBook.totalDays,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      HexColor('#F1B440')
                                                          .withOpacity(0.1),
                                                      HexColor('#F1B440'),
                                                    ]),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                ),
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 剩余天数
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${wordBook.totalDays - wordBook.learnedDays} days',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
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

class ProgressPainter extends CustomPainter {
  final int learned;
  final int total;
  final Color progressColor;
  final Color backgroundColor;

  ProgressPainter({
    required this.learned,
    required this.total,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    // 绘制背景圆
    canvas.drawCircle(center, radius, backgroundPaint);
    double progress = learned / total;
    // 计算进度圆弧的角度
    double angle = 2 * math.pi * progress;

    // 绘制进度圆弧
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 1.5, // Starting angle
      angle,
      false,
      progressPaint,
    );

    // 绘制进度文本
    String progressText = '$learned / $total';
    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold), text: progressText);
    TextPainter textPainter = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, new Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // 可以根据需要调整是否需要重绘
    return true;
  }
}
