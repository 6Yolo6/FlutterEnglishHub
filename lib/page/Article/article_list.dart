
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/articles_controller.dart';
import 'package:flutter_english_hub/model/Articles.dart';
import 'package:flutter_english_hub/page/article/news_detail.dart';
import 'package:flutter_english_hub/page/widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleListPage extends StatefulWidget {
  ArticleListPage({super.key});

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final ArticlesController articlesController = Get.find<ArticlesController>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    await articlesController.fetchLatestArticles();
    await articlesController.fetchArticles();
    setState(() {});
  }

  void _onRefresh() async {
    await articlesController.refreshArticles();
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await articlesController.fetchArticles();
    if (articlesController.hasMore.value) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article List'),
      ),
      body: articlesController.isLoading.value && articlesController.articlesList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    // if (articlesController.latestArticles.isNotEmpty)
                    //   SizedBox(
                    //     height: 177.h,
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: articlesController.latestArticles.length,
                    //       itemBuilder: (context, index) {
                    //         final article = articlesController.latestArticles[index];
                    //         return Container(
                    //           width: 318.w,
                    //           margin: EdgeInsets.only(left: 8, right: 8),
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                 width: 318.w,
                    //                 height: 80.h,
                    //                 decoration: BoxDecoration(
                    //                   color: Color(0xFFC4C4C4),
                    //                   image: DecorationImage(
                    //                     image: NetworkImage(article.urlToImage),
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(height: 8.h),
                    //               Row(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Expanded(
                    //                     child: Text(
                    //                       article.title,
                    //                       style: TextStyle(
                    //                         color: Colors.black,
                    //                         fontSize: 18.sp,
                    //                         fontFamily: 'Work Sans',
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                       overflow: TextOverflow.ellipsis,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 8.h),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Column(
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text(
                    //                         article.author ?? '',
                    //                         style: TextStyle(
                    //                           color: Colors.black,
                    //                           fontSize: 14.sp,
                    //                           fontFamily: 'Work Sans',
                    //                           fontWeight: FontWeight.w400,
                    //                         ),
                    //                       ),
                    //                       const SizedBox(height: 2),
                    //                       Text(
                    //                         '发布于: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(article.publishTime)}',
                    //                         style: TextStyle(
                    //                           color: Color(0xFFA8A8A8),
                    //                           fontSize: 12.sp,
                    //                           fontFamily: 'Work Sans',
                    //                           fontWeight: FontWeight.w400,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Row(
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       Icon(
                    //                         Icons.bookmark_border,
                    //                         size: 24.w,
                    //                       ),
                    //                       SizedBox(width: 24.w),
                    //                       Icon(
                    //                         Icons.more_vert,
                    //                         size: 24.w,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    
                    Divider(color: Color(0xFFD0D0D0)),
                    _buildArticlesList(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildArticlesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articlesController.articlesList.length + 1,
      itemBuilder: (context, index) {
        if (index == articlesController.articlesList.length) {
          return articlesController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink();
        }
        final article = articlesController.articlesList[index];
        return _buildArticleItem(article);
      },
    );
  }

  Widget _buildArticleItem(Articles article) {
    return ListTile(
      leading: Image.network(article.urlToImage, fit: BoxFit.cover, width: 100),
      title: Text(article.title),
      subtitle: Text(article.description),
      onTap: () {
        Get.to(() => NewsDetailPage(article: article),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 500));
      },
    );
  }
}

