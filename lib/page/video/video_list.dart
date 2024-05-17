import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/video_category_controller.dart';
import 'package:flutter_english_hub/controller/videos_controller.dart';
import 'package:flutter_english_hub/model/VideoCategory.dart';
import 'package:flutter_english_hub/model/Videos.dart';
import 'package:flutter_english_hub/page/video/video_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';


class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  late Future<List<VideoCategory>> futureCategories;
  late VideoCategoryController videoCategoryController = Get.find<VideoCategoryController>();
  late VideosController videosController = Get.find<VideosController>();

  @override
  void initState() {
    super.initState();
    futureCategories = videoCategoryController.fetchVideoCategory();
  }

  Future<List<Videos>> fetchVideos(int categoryId) async {
    return videosController.getVideosByCategoryId(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: Text(
          "Video List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder<List<VideoCategory>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load categories'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories available'));
          } else {
            return DefaultTabController(
              length: snapshot.data!.length,
              child: Scaffold(
                appBar: TabBar(
                  isScrollable: true,
                  tabs: snapshot.data!.map((category) => Tab(text: category.name)).toList(),
                ),
                body: TabBarView(
                  children: snapshot.data!.map((category) {
                    return FutureBuilder<List<Videos>>(
                      future: fetchVideos(category.id),
                      builder: (context, videoSnapshot) {
                        if (videoSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (videoSnapshot.hasError) {
                          return Center(child: Text('Failed to load videos'));
                        } else if (!videoSnapshot.hasData || videoSnapshot.data!.isEmpty) {
                          return Center(child: Text('No videos available'));
                        } else {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 19),
                            itemBuilder: (context, index) {
                              return VideoCard(videos: videoSnapshot.data![index]);
                            },
                            separatorBuilder: (BuildContext context, int index) => 16.verticalSpace,
                            itemCount: videoSnapshot.data!.length,
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Videos videos;

  const VideoCard({required this.videos, super.key});

  Future<String> _getThumbnail(String videoUrl) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      quality: 75,
    );
    return fileName!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getThumbnail(videos.filePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load thumbnail'));
        } else {
          return InkWell(
            // 跳转到视频详情页
            onTap: () {
              Get.to(() => VideoDetailPage(video: videos));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 151.w,
                  height: 83.h,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: FileImage(File(snapshot.data!)),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(color: Color(0xFF262626)),
                    child: Text(
                      videos.duration,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   videos.title,
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12.sp,
                      //     fontFamily: 'Work Sans',
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      // 2.verticalSpace,
                      Text(
                        videos.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.more_vert,
                  color: Color(0xffA8A8A8),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
