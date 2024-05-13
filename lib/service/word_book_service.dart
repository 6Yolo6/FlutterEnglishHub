import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/model/WordBook.dart';

class WordBookService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();
  
  // 获取单本单词书数据
  Future<WordBook> getWordBook() async {
    try {
      final response = await apiService.dio.get(
        'wordBooks/getByUserId',
      );
      print('单词书数据: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return WordBook.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load word book');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  
}