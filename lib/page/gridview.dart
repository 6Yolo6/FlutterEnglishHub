import 'package:flutter/material.dart';
import 'package:flutter_english_hub/page/widget/homelist.dart';
import 'package:flutter_english_hub/page/widget/swiper.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/controller/auth_controller.dart';
// 导入swiper
import 'package:card_swiper/card_swiper.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  final List<String> imageUrls = [
    "https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg",
    "https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg",
    "https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg",
    "https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 展示HomeList的内容
    return Scaffold(
      // body: Column(
      //   children: [
      //     // 顶部轮播图
      //     SizedBox(
      //       height: 250, // 增加高度
      //       child: Swiper(
      //         itemBuilder: (context, index) {
      //           return GestureDetector(
      //             onTap: () {
      //               // 点击事件
      //               if (index == 0) {
      //                 Get.toNamed('/daily-sentence');
      //               } else if (index == 1) {
      //                 Get.toNamed('/listening');
      //               } else if (index == 2) {
      //                 Get.toNamed('/reading');
      //               } else if (index == 3) {
      //                 Get.toNamed('/speaking');
      //               }
      //             },
      //             child: Image.network(
      //               imageUrls[index],
      //               fit: BoxFit.cover, // 保持图像比例
      //             ),
      //           );
      //         },
      //         itemCount: imageUrls.length, // 轮播图的数量
      //         viewportFraction: 0.8, // 确保视口不会过多覆盖
      //         scale: 0.85, // 缩小比例，避免冲突
      //         pagination: SwiperPagination(), // 分页指示器
      //         // control: SwiperControl(), // 控制按钮
      //         physics: const BouncingScrollPhysics(), // 允许滚动
      //       ),
      //     ),
      //
      //     Expanded(
      //       child: GridView.builder(
      //         padding: const EdgeInsets.all(12),
      //         itemCount: HomeList.homeList.length,
      //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2, // 一行两个
      //           crossAxisSpacing: 10, // 横向间距
      //           mainAxisSpacing: 10, // 纵向间距
      //           childAspectRatio: 1.0,
      //         ),
      //         itemBuilder: (context, index) {
      //           final homeItem = HomeList.homeList[index];
      //           return GestureDetector(
      //             onTap: () {
      //               Get.toNamed(homeItem.routeName);
      //             },
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: const BorderRadius.all(Radius.circular(8)),
      //                 boxShadow: <BoxShadow>[
      //                   BoxShadow(
      //                     color: Colors.grey.withOpacity(0.2),
      //                     offset: const Offset(1.1, 1.1),
      //                     blurRadius: 10.0,
      //                   ),
      //                 ],
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Image.asset(
      //                     homeItem.imagePath,
      //                     fit: BoxFit.cover,
      //                   ),
      //                   const SizedBox(height: 10),
      //                   Text(
      //                     homeItem.routeName.split('/').last,// 获取路由名称作为文本显示
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.w500,
      //                       color: Colors.grey.withOpacity(0.8),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SwiperPage(imageUrls: imageUrls),
          ),
          // 将 GridView 放入 Sliver，实现滚动
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 17.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Section(
                    title: 'Hot topics',
                    child: SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          margin: EdgeInsets.only(
                            left: index == 0 ? 13.w : 0,
                            right: 8.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 129.w,
                                height: 129.w,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFA8A8A8)),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Image.network(
                                  'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg',
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                'Topic #1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Work Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 3,
                      ),
                    ),
                  ),
                  Section(
                    title: 'Playlist',
                    child: SizedBox(
                      height: 268.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          width: 168.w,
                          margin: EdgeInsets.only(
                            left: index == 0 ? 12.w : 0,
                            right: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0x7FD0D0D0),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 168.w,
                                height: 180.h,
                                decoration:
                                    BoxDecoration(color: Color(0xFFC4C4C4)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 11.h, horizontal: 7.w),
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration:
                                      BoxDecoration(color: Color(0xFF262626)),
                                  child: Text(
                                    '11 talks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Work Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 4.w,
                                    right: 4.w,
                                    left: 4.w,
                                    bottom: 4.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Biden Ends Infrastructure Talks With Senate GOP Group.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontFamily: 'Work Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    Icon(Icons.more_vert),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 3,
                      ),
                    ),
                  ),
                  41.verticalSpace,
                  Section(
                      title: "Speakers",
                      child: SizedBox(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (context, index) => Container(
                            width: 105,
                            height: 105,
                            margin: EdgeInsets.only(
                              left: 12.0,
                              right: 4,
                            ),
                            decoration: ShapeDecoration(
                              color: Color(0xFFC4C4C4),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      )
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final Widget child;

  const Section({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          12.verticalSpace,
          child,
        ],
      ),
    );
  }
}
