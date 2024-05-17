// import 'package:flutter/material.dart';

// import 'package:flutter_english_hub/page/reading/ebook_category.dart';

// class ReadingPage extends StatefulWidget {
//   const ReadingPage({super.key});

//   @override
//   _ReadingPageState createState() => _ReadingPageState();
// }

// class _ReadingPageState extends State<ReadingPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // 分类列表
//   List<Map<String, dynamic>> categories = [
//     {'id': 1, 'name': '美文'},
//     {'id': 2, 'name': '幽默'},
//     {'id': 3, 'name': '诗歌'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: categories.length, vsync: this);
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('分类'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: categories.map((category) {
//             return Tab(text: category['name']);
//           }).toList(),
//         ),
//       ),
//       body: Stack(
//         children: [
//           TabBarView(
//             controller: _tabController,
//             children: categories.map((category) {
//               return EBookCategory(categoryId: category['id']);
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_english_hub/controller/articles_controller.dart';
import 'package:flutter_english_hub/model/Articles.dart';
import 'package:flutter_english_hub/page/article/article_list.dart';
import 'package:flutter_english_hub/page/article/news_detail.dart';
import 'package:flutter_english_hub/page/reading/browser.dart';
import 'package:flutter_english_hub/page/reading/eBook.dart';
import 'package:flutter_english_hub/page/reading/ebook_category.dart';
import 'package:flutter_english_hub/page/reading/news_hotwords.dart';
import 'package:get/get.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final ArticlesController articlesController = Get.find<ArticlesController>();

  final List<String> imageUrls = [
    "assets/images/swiper/book-1835799_1280.jpg",
    "assets/images/swiper/book-419589_1280.jpg",
    ];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    await articlesController.fetchArticles();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSwiper(),
            _buildGrid(),
            _buildArticlesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSwiper() {
    return Container(
      height: 200.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            imageUrls[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: imageUrls.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        children: [
          _buildGridItem(Icons.article, '新闻', ArticleListPage()),
          _buildGridItem(Icons.trending_up, '热词', NewsHotwordsPage()),
          _buildGridItem(Icons.book, '电子书', EBookPage()),
          _buildGridItem(Icons.web, '浏览器', BrowserPage()),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Get.to(() => page, transition: Transition.fade, duration: const Duration(milliseconds: 500));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40.0),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildArticlesList() {
  return Obx(() {
    if (articlesController.isLoading.value && articlesController.articlesList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else if (articlesController.articlesList.isEmpty) {
      return Center(child: Text("No articles found"));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !articlesController.isLoading.value) {
          print("Reached end of list, attempting to fetch more...");
          articlesController.fetchArticles();
        }
        return true;
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),  // Consider changing this if you want the list to scroll independently
        itemCount: articlesController.articlesList.length + (articlesController.isLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == articlesController.articlesList.length && articlesController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          final article = articlesController.articlesList[index];
          return _buildArticleItem(article);
        },
      ),
    );
  });
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
