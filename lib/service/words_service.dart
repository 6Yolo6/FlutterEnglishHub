import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class WordsService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();

  // 根据name模糊分页获取单词
  Future<Object> searchByName(String word, int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get(
        'words/searchByName',
        queryParameters: {
          'word': word,
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on dio.DioError catch (e) {
      print('e: ${e}');
      return e;
    }
    return {};
  }

  // 清除单词搜索历史记录
  Future<Object> clearSearchHistory() async {
    try {
      final response = await apiService.dio.post(
        'words/clearSearchHistory',
      );
      String message = response.data['message'];
      if (response.statusCode == 200) {
        apiService.showFeedback('', message, Colors.green);
        return response.data;
      }
    } on dio.DioError catch (e) {
      print('e: ${e}');
    }
    return {};
  }

  // 获取单词搜索历史记录
  Future<Object> getSearchHistory() async {
    try {
      final response = await apiService.dio.get(
        'words/getSearchHistory',
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on dio.DioError catch (e) {
      print('e: ${e}');
      return e;
    }
    return {};
  }
}
