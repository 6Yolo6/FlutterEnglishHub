import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';

class SwiperPage extends StatelessWidget {
  final List<String> imageUrls;

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
                Get.toNamed('/daily-sentence');
              } else if (index == 1) {
                Get.toNamed('/listening');
              } else if (index == 2) {
                Get.toNamed('/reading');
              } else if (index == 3) {
                Get.toNamed('/speaking');
              }
            },
            child: Image.network(
              imageUrls[index], // 网络图片
              fit: BoxFit.fill, // 保持图像比例
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