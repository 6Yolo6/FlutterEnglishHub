import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/news_hotwords_controller.dart';
import 'package:flutter_english_hub/model/NewsHotwords.dart';
import 'package:flutter_english_hub/page/reading/hotword_detail.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsHotwordsPage extends StatefulWidget {
  @override
  _NewsHotwordsPageState createState() => _NewsHotwordsPageState();
}

class _NewsHotwordsPageState extends State<NewsHotwordsPage> {
  final NewsHotwordsController newsHotwordsController = Get.find<NewsHotwordsController>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('每日热词'),
      ),
      body: Obx(() {
        if (newsHotwordsController.isLoading.value && newsHotwordsController.hotwordsList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              itemCount: newsHotwordsController.hotwordsList.length,
              itemBuilder: (context, index) {
                NewsHotwords hotword = newsHotwordsController.hotwordsList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => HotwordDetailPage(hotword: hotword));
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hotword.imageUrl.isNotEmpty)
                          Image.network(hotword.imageUrl),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotword.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                hotword.description,
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '来源: ${hotword.sourceName}',
                                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '发布时间: ${hotword.publishTime.toLocal().toString().split(' ')[0]}',
                                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                              ),
                            ],
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
      }),
    );
  }

  void _onRefresh() async {
    await newsHotwordsController.refreshHotwords();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await newsHotwordsController.fetchHotwords();
    if (newsHotwordsController.hasMore.value) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }
}
