
import 'package:flutter_english_hub/model/Articles.dart';
import 'package:flutter_english_hub/service/articles_service.dart';
import 'package:get/get.dart';

class ArticlesController extends GetxController {
  final ArticlesService articlesService = Get.find<ArticlesService>();
  var articlesList = <Articles>[].obs;
  var latestArticles = <Articles>[].obs;
  var isLoading = true.obs;
  var pageNum = 1.obs;
  var pageSize = 10.obs;
  var hasMore = true.obs;
  
  var currentPage = 1.obs;

  @override
  void onInit() {
    fetchArticles();
    fetchLatestArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    if (isLoading.value || !hasMore.value) return;

    try {
      isLoading(true);
      var articles = await articlesService.getArticles(pageNum.value, pageSize.value);
      if (articles.length < pageSize.value) {
        hasMore(false);
      }
      articlesList.addAll(articles);
      pageNum.value++;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshArticles() async {
    try {
      isLoading(true);
      pageNum.value = 1;
      hasMore(true);
      var articles = await articlesService.getArticles(pageNum.value, pageSize.value);
      articlesList.assignAll(articles);
      if (articles.length < pageSize.value) {
        hasMore(false);
      }
      pageNum.value++;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchLatestArticles() async {
    try {
      isLoading(true);
      var latest = await articlesService.getLatestArticles(5);
      latestArticles.assignAll(latest);
    } finally {
      isLoading(false);
    }
  }

   Future<void> getArticles() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      var result = await articlesService.getArticles(currentPage.value, 5);
      if (result.isNotEmpty) {
        articlesList.addAll(result);
        currentPage++;
      } else {
        print("No more data available to load.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }


  // 获取最新top条文章新闻
  Future<List<Articles>> getLatestArticles(int top) async {
    var result = await articlesService.getLatestArticles(top);
    return result;
  }

  Future<Articles> getArticleDetail(int id) async {
    var result = await articlesService.getArticleDetail(id);
    return result;
  }
}