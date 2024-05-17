import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/videos_controller.dart';
import 'package:flutter_english_hub/page/daily_sentence/daily_sentence_list.dart';
import 'package:flutter_english_hub/page/video/video_list.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListeningPage extends StatefulWidget {
  @override
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  final VideosController videosController = Get.find<VideosController>();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    await videosController.getVideosPage();
    setState(() {});
  }

  void _onRefresh() async {
    await videosController.refreshVideos();
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await videosController.getVideosPage();
    _refreshController.loadComplete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopGrid(),
              Divider(color: Color(0xFFD0D0D0)),
              _buildVideoList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopGrid() {
    final List<Map<String, dynamic>> gridItems = [
      {'title': '每日一句', 'route': () => DailySentenceList()},
      {'title': '视频', 'route': () => VideoListPage()},
      // Add more items here
    ];
  
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2,
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        final item = gridItems[index];
        return GestureDetector(
          onTap: () {
            Get.to(item['route']());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                item['title'],
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: videosController.videosList.length,
      itemBuilder: (context, index) {
        final video = videosController.videosList[index];
        return VideoCard(videos: video);
      },
    );
  }
}
