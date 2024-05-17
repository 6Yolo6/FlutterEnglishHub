import 'package:flutter_english_hub/model/Articles.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class ArticlesService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 分页获取文章列表
  Future<List<Articles>> getArticles(int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get('articles/getPage',
        queryParameters: {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },);

      print('双语新闻列表: ${response.data}');
      if (response.data != null && response.data['data'] != null && response.data['data']['records'] != null) {
        return (response.data['data']['records'] as List)
            .map((item) => Articles.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 获取最新top条文章
  Future<List<Articles>> getLatestArticles(int top) async {
    try {
      final response = await apiService.dio.get('articles/getTop',
        queryParameters: {
          'top': top,
        },);

      print('最新文章列表: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => Articles.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  Future<Articles> getArticleDetail(int id) async {
    try {
      final response = await apiService.dio.get('articles/getById',
        queryParameters: {
          'id': id,
        },);

      print('文章详情: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return Articles.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }
}
