import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/articles_controller.dart';
import 'package:flutter_english_hub/controller/e_books_controller.dart';
import 'package:flutter_english_hub/controller/videos_controller.dart';
import 'package:flutter_english_hub/model/Articles.dart';
import 'package:flutter_english_hub/model/EBooks.dart';
import 'package:flutter_english_hub/model/Videos.dart';
import 'package:flutter_english_hub/page/article/article_list.dart';
import 'package:flutter_english_hub/page/article/news_detail.dart';
import 'package:flutter_english_hub/page/reading/ebook_category.dart';
import 'package:flutter_english_hub/page/video/video_detail.dart';
import 'package:flutter_english_hub/page/video/video_list.dart';
import 'package:flutter_english_hub/page/widget/swiper.dart';
import 'package:flutter_english_hub/service/reading_progress_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_english_hub/page/reading/epub_view.dart';
import 'package:flutter_english_hub/page/reading/pdf_view.dart';
import 'package:flutter_english_hub/page/reading/blank_image_with_text.dart';

import 'package:pdfrx/pdfrx.dart';
class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  final ArticlesController articlesController = Get.find<ArticlesController>();
  final VideosController videosController = Get.find<VideosController>();
  final EBooksController eBooksController = Get.find<EBooksController>();

  final List<String> imageUrls = [
    "assets/images/swiper/governor-2813120_1280.jpg",
    "assets/images/swiper/education-4382169_1280.jpg",
    "assets/images/swiper/book-6957870_1280.jpg",
    "assets/images/swiper/beach-7546731_1920.jpg",
  ];

  List<Articles> articles = [];
  List<Videos> videos = [];
  List<EBooks> eBooks = [];
  List<String?> thumbnails = [];

  @override
  void initState() {
    super.initState();
    // _getData();
  }

  Future<List<Articles>> _getArticles() async {
    articles = await articlesController.getLatestArticles(3);

    return articles;
  }

  Future<List<EBooks>> _getEBooks() async {
    eBooks = await eBooksController.getLatestEBooks();

    return eBooks;
  }

  // Future<List<Videos>> _getVideos() async {
  //   videos = await videosController.getLatestVideos();

  //   return videos;
  // }

  Future<List<Videos>> _getVideos() async {
  videos = await videosController.getLatestVideos();
  thumbnails = List<String?>.filled(videos.length, null);  // 初始化缩略图列表
  for (var index = 0; index < videos.length; index++) {
    var video = videos[index];
    thumbnails[index] = await _getVideoThumbnail(video.filePath);
  }
  return videos;
}



  Future<String?> _getVideoThumbnail(String videoUrl) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      quality: 75,
    );
    return fileName;
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   // 展示HomeList的内容
  //   return Scaffold(
  //     // body: Column(
  //     //   children: [
  //     //     // 顶部轮播图
  //     //     SizedBox(
  //     //       height: 250, // 增加高度
  //     //       child: Swiper(
  //     //         itemBuilder: (context, index) {
  //     //           return GestureDetector(
  //     //             onTap: () {
  //     //               // 点击事件
  //     //               if (index == 0) {
  //     //                 Get.toNamed('/daily-sentence');
  //     //               } else if (index == 1) {
  //     //                 Get.toNamed('/listening');
  //     //               } else if (index == 2) {
  //     //                 Get.toNamed('/reading');
  //     //               } else if (index == 3) {
  //     //                 Get.toNamed('/speaking');
  //     //               }
  //     //             },
  //     //             child: Image.network(
  //     //               imageUrls[index],
  //     //               fit: BoxFit.cover, // 保持图像比例
  //     //             ),
  //     //           );
  //     //         },
  //     //         itemCount: imageUrls.length, // 轮播图的数量
  //     //         viewportFraction: 0.8, // 确保视口不会过多覆盖
  //     //         scale: 0.85, // 缩小比例，避免冲突
  //     //         pagination: SwiperPagination(), // 分页指示器
  //     //         // control: SwiperControl(), // 控制按钮
  //     //         physics: const BouncingScrollPhysics(), // 允许滚动
  //     //       ),
  //     //     ),
  //     //
  //     //     Expanded(
  //     //       child: GridView.builder(
  //     //         padding: const EdgeInsets.all(12),
  //     //         itemCount: HomeList.homeList.length,
  //     //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //     //           crossAxisCount: 2, // 一行两个
  //     //           crossAxisSpacing: 10, // 横向间距
  //     //           mainAxisSpacing: 10, // 纵向间距
  //     //           childAspectRatio: 1.0,
  //     //         ),
  //     //         itemBuilder: (context, index) {
  //     //           final homeItem = HomeList.homeList[index];
  //     //           return GestureDetector(
  //     //             onTap: () {
  //     //               Get.toNamed(homeItem.routeName);
  //     //             },
  //     //             child: Container(
  //     //               decoration: BoxDecoration(
  //     //                 color: Colors.white,
  //     //                 borderRadius: const BorderRadius.all(Radius.circular(8)),
  //     //                 boxShadow: <BoxShadow>[
  //     //                   BoxShadow(
  //     //                     color: Colors.grey.withOpacity(0.2),
  //     //                     offset: const Offset(1.1, 1.1),
  //     //                     blurRadius: 10.0,
  //     //                   ),
  //     //                 ],
  //     //               ),
  //     //               child: Column(
  //     //                 mainAxisAlignment: MainAxisAlignment.center,
  //     //                 children: <Widget>[
  //     //                   Image.asset(
  //     //                     homeItem.imagePath,
  //     //                     fit: BoxFit.cover,
  //     //                   ),
  //     //                   const SizedBox(height: 10),
  //     //                   Text(
  //     //                     homeItem.routeName.split('/').last,// 获取路由名称作为文本显示
  //     //                     style: TextStyle(
  //     //                       fontSize: 16,
  //     //                       fontWeight: FontWeight.w500,
  //     //                       color: Colors.grey.withOpacity(0.8),
  //     //                     ),
  //     //                   ),
  //     //                 ],
  //     //               ),
  //     //             ),
  //     //           );
  //     //         },
  //     //       ),
  //     //     ),
  //     //   ],
  //     // ),

  //     body: CustomScrollView(
  //       slivers: [
  //         SliverToBoxAdapter(
  //           child: SwiperPage(imageUrls: imageUrls),
  //         ),
  //         // 将 GridView 放入 Sliver，实现滚动
  //         SliverPadding(
  //           padding: EdgeInsets.symmetric(vertical: 17.h),
  //           sliver: SliverList(
  //             delegate: SliverChildListDelegate(
  //               [
  //                 Section(
  //                   title: '双语阅读',
  //                   child: SizedBox(
  //                     height: 180,
  //                     child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemBuilder: (BuildContext context, int index) =>
  //                           Container(
  //                         margin: EdgeInsets.only(
  //                           left: index == 0 ? 13.w : 0,
  //                           right: 8.w,
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                               width: 129.w,
  //                               height: 129.w,
  //                               decoration: ShapeDecoration(
  //                                 shape: RoundedRectangleBorder(
  //                                   side: BorderSide(
  //                                       width: 1, color: Color(0xFFA8A8A8)),
  //                                 ),
  //                               ),
  //                               alignment: Alignment.center,
  //                               child: Image.network(
  //                                 'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg',
  //                                 width: 50.w,
  //                                 height: 50.h,
  //                               ),
  //                             ),
  //                             4.verticalSpace,
  //                             Text(
  //                               'Topic #1',
  //                               style: TextStyle(
  //                                 color: Colors.black,
  //                                 fontSize: 14,
  //                                 fontFamily: 'Work Sans',
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       itemCount: 3,
  //                     ),
  //                   ),
  //                 ),
  //                 Section(
  //                   title: '视频',
  //                   child: SizedBox(
  //                     height: 268.h,
  //                     child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemBuilder: (BuildContext context, int index) =>
  //                           Container(
  //                         width: 168.w,
  //                         margin: EdgeInsets.only(
  //                           left: index == 0 ? 12.w : 0,
  //                           right: 16.w,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Color(0x7FD0D0D0),
  //                         ),
  //                         child: Column(
  //                           children: [
  //                             Container(
  //                               width: 168.w,
  //                               height: 180.h,
  //                               decoration:
  //                                   BoxDecoration(color: Color(0xFFC4C4C4)),
  //                               padding: EdgeInsets.symmetric(
  //                                   vertical: 11.h, horizontal: 7.w),
  //                               alignment: Alignment.bottomRight,
  //                               child: Container(
  //                                 padding: EdgeInsets.all(2.w),
  //                                 decoration:
  //                                     BoxDecoration(color: Color(0xFF262626)),
  //                                 child: Text(
  //                                   '11 talks',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 12.sp,
  //                                     fontFamily: 'Work Sans',
  //                                     fontWeight: FontWeight.w400,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.only(
  //                                   top: 4.w,
  //                                   right: 4.w,
  //                                   left: 4.w,
  //                                   bottom: 4.w),
  //                               child: Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Expanded(
  //                                     child: Text(
  //                                       'Biden Ends Infrastructure Talks With Senate GOP Group.',
  //                                       style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontSize: 12.sp,
  //                                         fontFamily: 'Work Sans',
  //                                         fontWeight: FontWeight.w600,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   5.horizontalSpace,
  //                                   Icon(Icons.more_vert),
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       itemCount: 3,
  //                     ),
  //                   ),
  //                 ),
  //                 41.verticalSpace,
  //                 Section(
  //                     title: "口语课程",
  //                     child: SizedBox(
  //                       height: 110,
  //                       child: ListView.builder(
  //                         scrollDirection: Axis.horizontal,
  //                         itemCount: 7,
  //                         itemBuilder: (context, index) => Container(
  //                           width: 105,
  //                           height: 105,
  //                           margin: EdgeInsets.only(
  //                             left: 12.0,
  //                             right: 4,
  //                           ),
  //                           decoration: ShapeDecoration(
  //                             color: Color(0xFFC4C4C4),
  //                             shape: OvalBorder(),
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                   ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SwiperPage(imageUrls: imageUrls),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildArticlesSection(),
                  buildVideosSection(),
                  buildEBooksSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArticlesSection() {
  return FutureBuilder<List<Articles>>(
    future: _getArticles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return Section(
          title: '双语阅读',
          child: buildArticlesList(snapshot.data!),
          onViewAll: () => Get.to(() => ArticleListPage(), transition: Transition.fade, duration: Duration(milliseconds: 500)),
        );
      }
    },
  );
}

  Widget buildVideosSection() {
  return FutureBuilder<List<Videos>>(
    future: _getVideos(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return Section(
          title: '视频',
          child: buildVideosList(snapshot.data!),
          onViewAll: () => Get.to(() => VideoListPage(), transition: Transition.fade, duration: Duration(milliseconds: 500)),
        );
      }
    },
  );
}

Widget buildVideosList(List<Videos> videos) {
  return SizedBox(
    height: 220,  // 增加高度以容纳内容
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        var video = videos[index];
        return GestureDetector(
          onTap: () {
            // 跳转详情页
            Get.to(() => VideoDetailPage(video: video), transition: Transition.fade, duration: Duration(milliseconds: 500));
          },
          child: Container(
            width: 160,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        image: DecorationImage(
                          image: thumbnails.isNotEmpty && thumbnails[index] != null 
                          ? FileImage(File(thumbnails[index]!)) 
                          : AssetImage('assets/images/default_thumbnail.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: Colors.black.withOpacity(0.7),
                        child: Text(
                          video.duration,  
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Text(
                        //   video.description,
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}


  Widget buildArticlesList(List<Articles> articles) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 10.w, right: 10.w),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          var article = articles[index];
          return GestureDetector(
            onTap: () {
              // 跳转详情页
              Get.to(() => NewsDetailPage(article: article), transition: Transition.fade, duration: Duration(milliseconds: 500));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          article.description,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.urlToImage,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget buildEBooksList(List<EBooks> eBooks) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eBooks.length,
        itemBuilder: (context, index) {
          var ebook = eBooks[index];
          return GestureDetector(
            onTap: () async {
              if (ebook.fileType == 'pdf') {
                await _openPdf(ebook);
              } else if (ebook.fileType == 'epub') {
                await _openEpub(ebook);
              }
            },
            child: Container(
              width: 160,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(
                          ebook.fileType == 'pdf'
                          ? 'https://example.com/pdf_thumbnail.png'
                          : 'https://example.com/epub_thumbnail.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ebook.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ebook.author ?? '',
                            maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openPdf(EBooks ebook) async {
    final pdfDocument = await PdfDocument.openUri(Uri.parse(ebook.filePath));
    if (pdfDocument != null) {
      Get.to(
        PdfView(
          pdfPath: ebook.filePath,
          eBookId: ebook.id,
          currentPage: 1, // You can customize the initial page here
        ),
        transition: Transition.fade,
        duration: Duration(seconds: 1),
      );
    }
  }

  // 获取阅读进度
  Future<String> _getReadingProgress(int ebookId) async {
    final ReadingProgressService readingProgressService =
        Get.find<ReadingProgressService>();
    final progress = await readingProgressService.getProgress(ebookId)
        as Map<String, dynamic>; // 使用类型转换
    print('阅读进度：${progress['progress']}');
    return progress['progress'];
    // 'epubcfi(/6/6[chapter-2]!/4/2/1612)'
  }

  Future<void> _openEpub(EBooks ebook) async {
    final initialCfi = await _getReadingProgress(ebook.id);
    Get.to(
      EpubViewer(
        epubUrl: ebook.filePath,
        ebookId: ebook.id,
        initialCfi: initialCfi,
      ),
      transition: Transition.fade,
      duration: Duration(seconds: 1),
    );
  }

// Widget buildEBooksList(List<EBooks> eBooks) {
//   return SizedBox(
//     height: 200, 
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: eBooks.length,
//       itemBuilder: (context, index) {
//         var ebook = eBooks[index];
//         return Container(
//           width: 160,
//           margin: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 120,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       ebook.fileType == 'pdf' 
//                       ? 'https://example.com/pdf_thumbnail.png' 
//                       : 'https://example.com/epub_thumbnail.png',
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         ebook.title,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         ebook.author ?? '',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

Widget buildEBooksSection() {
  return FutureBuilder<List<EBooks>>(
    future: _getEBooks(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return Section(
          title: '电子书',
          child: buildEBooksList(snapshot.data!),
          onViewAll: () => Get.to(() => EBookCategoryPage(categoryId: 1), transition: Transition.fade, duration: Duration(milliseconds: 500)),
        );
      }
    },
  );
}

}

class Section extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onViewAll;

  const Section({
    super.key,
    required this.title,
    required this.child,
    required this.onViewAll,
  });

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
                  onTap: onViewAll,
                  child: Text(
                    '更多',
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
