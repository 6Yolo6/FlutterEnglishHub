import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/articles_controller.dart';
import 'package:flutter_english_hub/model/Articles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewsDetailPage extends StatefulWidget {
  final Articles article;
  const NewsDetailPage({super.key, required this.article});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isFavorite = false;
  String displayLanguage = 'Both'; // Options: 'Both', 'Chinese', 'English'
  final ArticlesController articlesController = Get.find<ArticlesController>();
  Articles? articleDetail;
  
  @override
  void initState() {
    super.initState();
    _fetchArticleDetail();
  }

  Future<void> _fetchArticleDetail() async {
    articleDetail = await articlesController.getArticleDetail(widget.article.id);
    setState(() {});
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: articleDetail == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        articleDetail!.urlToImage,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                            ),
                            PopupMenuButton<String>(
                              onSelected: (String value) {
                                setState(() {
                                  displayLanguage = value;
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Both',
                                  child: Text('显示双语'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Chinese',
                                  child: Text('仅显示中文'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'English',
                                  child: Text('仅显示英文'),
                                ),
                              ],
                              icon: Icon(Icons.settings),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          getDisplayText(articleDetail!.title),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${articleDetail!.author}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '发布于: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(articleDetail!.publishTime)}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        getContentWidget(articleDetail!.content),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget getContentWidget(String content) {
    List<dynamic> parsedContent;
    try {
      parsedContent = json.decode(content);
    } catch (e) {
      parsedContent = [content];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parsedContent.map((segment) {
        if (segment is List<dynamic>) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: segment.map((text) {
              return Text(getDisplayText(text.toString()), style: TextStyle(fontSize: 16));
            }).toList(),
          );
        } else {
          return Text(getDisplayText(segment.toString()), style: TextStyle(fontSize: 16));
        }
      }).toList(),
    );
  }

  String getDisplayText(String text) {
    if (displayLanguage == 'Chinese') {
      // 假设中文和英文用句号分隔
      var parts = text.split('. ');
      return parts.length > 1 ? parts[1] : text;
    } else if (displayLanguage == 'English') {
      // 假设中文和英文用句号分隔
      var parts = text.split('. ');
      return parts[0];
    }
    return text; // 默认返回双语内容
  }
}
