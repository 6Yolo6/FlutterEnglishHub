import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_english_hub/page/article/article_list.dart';
import 'package:flutter_english_hub/page/daily_sentence/daily_sentence_list.dart';
import 'package:flutter_english_hub/page/reading/article.dart';
import 'package:flutter_english_hub/page/spoken/spoken.dart';
import 'package:flutter_english_hub/page/video/video_list.dart';
import 'package:get/get.dart';

class SwiperPage extends StatelessWidget {
  final List<String> imageUrls;
  final List<String> titles = ['TED演讲', '每日一句', '双语阅读', '口语课程'];

  SwiperPage({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // 轮播图高度
      child: Swiper(
        itemBuilder: (context, index) {
          return GestureDetector(
            // 跳转到对应页面
            onTap: () {
              if (index == 0) {
                // TED演讲视频页面
                Get.to( () => VideoListPage(), transition: Transition.fade, duration: const Duration(milliseconds: 500));
              } else if (index == 1) {
                // 每日一句页面
                Get.to( () => DailySentenceList(), transition: Transition.fade, duration: const Duration(milliseconds: 500));
              } else if (index == 2) {
                // 双语阅读页面
                Get.to( () => ArticleListPage(), transition: Transition.fade, duration: const Duration(milliseconds: 500));
              } else if (index == 3) {
                // 口语课程页面
                Get.to( () => SpokenPage(), transition: Transition.fade, duration: const Duration(milliseconds: 500));
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imageUrls[index], // 图片
                  fit: BoxFit.fill, // 保持图像比例
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.blue, // 文字背景色
                      borderRadius: BorderRadius.circular(10.0), // 圆角边框
                    ),
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: imageUrls.length, // 轮播图的数量
        viewportFraction: 0.8, // 视口占比
        scale: 0.85, // 缩放比例
        pagination: const SwiperPagination(), // 分页指示器
        physics: const BouncingScrollPhysics(), // 允许滑动
        autoplay: true, // 自动播放
      ),
    );
  }
}