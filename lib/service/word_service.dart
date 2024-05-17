
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/model/Word.dart';
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class WordService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();

  // 根据name模糊获取单词list
  Future<List<WordReview>> searchByName(String word) async {
    try {
      final response = await apiService.dio.get(
        'word/searchByName',
        queryParameters: {
          'word': word,
        },
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => WordReview.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load words');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 清除单词搜索历史记录
  Future clearSearchHistory() async {
    try {
      final response = await apiService.dio.post(
        'word/clearSearchHistory',
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
  Future<List<WordReview>> getSearchHistory() async {
    try {
      final response = await apiService.dio.get(
        'word/getSearchHistory',
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => WordReview.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load search history');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 根据wordBookId获取单词分页数据
  Future<List<Word>> getByWordBookId(int wordBookId, int pageNum, int pageSize) async {
  try {
    final response = await apiService.dio.get(
      'word/getPageByWordBookId',
      queryParameters: {
        'wordBookId': wordBookId,
        'pageNum': pageNum,
        'pageSize': pageSize,
      },
    );
    if (response.data != null && response.data['data'] != null && response.data['data']['records'] != null) {
      print('单词列表: ${response.data['data']['records']}');
      return (response.data['data']['records'] as List)
          .map((item) => Word.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load words: Response was not in the expected format.');
    }
  } catch (e) {
    print('Error fetching words: $e');
    throw e;
  }
}

  // 根据wordId获取单词详情
  Future<WordReview> getWordDetail(int wordId) async {
    try {
      final response = await apiService.dio.get(
        'word/getDetail',
        queryParameters: {
          'wordId': wordId,
        },
      );
      if (response.statusCode == 200) {
        return WordReview.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load word detail');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }
}
