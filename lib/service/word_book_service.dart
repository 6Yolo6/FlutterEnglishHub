import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_english_hub/model/WordBooks.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/model/WordBook.dart';

class WordBookService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();
  
  // 根据userId获取单词书数据
  Future<WordBook> getWordBook() async {
    try {
      final response = await apiService.dio.get('wordBooks/getByUserId');
      print('单词书数据: ${response.data}');
      if (response.data['data'] != null) {
        return WordBook.fromJson(response.data['data']);
      } else {
        // 处理空数据
        return WordBook.empty(); // 返回一个空的WordBook对象，其中的字段都设置为默认值
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 根据categoryId分页获取单词书数据
  Future<List<WordBooks>> getPageByCategoryId(int categoryId, int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get(
        'wordBooks/getPageByCategoryId', 
        queryParameters: {
        'categoryId': categoryId,
        'pageNum': pageNum,
        'pageSize': pageSize,
      });
      if (response.statusCode == 200) {
        return (response.data['data']['records'] as List).map((item) => WordBooks.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load word book');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 根据categoryId获取单词书列表
  Future<List<WordBooks>> getWordBooksByCategoryId(int categoryId) async {
    try {
      final response = await apiService.dio.get(
        'wordBooks/getByCategoryId', 
        queryParameters: {
        'categoryId': categoryId,
      });
      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => WordBooks.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load word book');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

}