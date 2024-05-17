import 'package:flutter/material.dart';
import 'package:flutter_english_hub/model/Videos.dart';
import 'package:flutter_english_hub/service/videos_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final Videos video;
  const VideoDetailPage({super.key, required this.video});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late CachedVideoPlayerController cachedVideoPlayerController;
  late CustomVideoPlayerController customVideoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  late Future<List<Videos>> relatedVideos;
  final VideosService videosService = Get.find<VideosService>();

  @override
  void initState() {
    super.initState();
    cachedVideoPlayerController = CachedVideoPlayerController.network(widget.video.filePath);
    _initializeVideoPlayerFuture = cachedVideoPlayerController.initialize();
    customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: cachedVideoPlayerController,
    );
    relatedVideos = videosService.getVideosByCategoryId(widget.video.category);
  }

  @override
  void dispose() {
    cachedVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 215.h,
              child: FutureBuilder<void>(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CustomVideoPlayer(customVideoPlayerController: customVideoPlayerController);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                children: [
                  Text(
                    widget.video.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      Text(
                        'Duration: ${widget.video.duration}',
                        style: TextStyle(
                          color: Color(0xFFA8A8A8),
                          fontSize: 12.sp,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      16.horizontalSpace,
                      Container(
                        height: 15.h,
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            width: 1,
                            color: Color(0xFFA8A8A8),
                          ),
                        )),
                      ),
                      16.horizontalSpace,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.volume_up,
                            color: Color(0xffA8A8A8),
                          ),
                          4.horizontalSpace,
                          Text(
                            'Listen',
                            style: TextStyle(
                              color: Color(0xFFA8A8A8),
                              fontSize: 12.sp,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.playlist_add,
                      ),
                      20.horizontalSpace,
                      Icon(
                        Icons.favorite_outline,
                      ),
                      20.horizontalSpace,
                      Icon(
                        Icons.download,
                      ),
                      20.horizontalSpace,
                      Icon(
                        Icons.share,
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    'Related Videos',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  16.verticalSpace,
                  FutureBuilder<List<Videos>>(
                    future: relatedVideos,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Failed to load related videos'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No related videos available'));
                      } else {
                        return Column(
                          children: snapshot.data!
                              .map((video) => RelatedVideoCard(video: video))
                              .toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RelatedVideoCard extends StatelessWidget {
  final Videos video;
  const RelatedVideoCard({required this.video, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => VideoDetailPage(video: video));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 151.w,
            height: 83.h,
            decoration: ShapeDecoration(
              color: Color(0x7FC4C4C4),
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
                video.duration,
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
                Text(
                  video.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                2.verticalSpace,
                Text(
                  video.description,
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
          ),
        ],
      ),
    );
  }
}
