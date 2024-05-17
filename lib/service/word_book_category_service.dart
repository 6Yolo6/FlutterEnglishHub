import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_english_hub/model/WordBookCategory.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class WordBookCategoryService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();

  Future<List<WordBookCategory>> getWordBookCategory() async {
    try {
      final response = await apiService.dio.get('wordBookCategory/getAll');

      print('单词书: ${response.data}');
      if (response.data['data'] != null) {
        return (response.data['data'] as List).map((item)
         => WordBookCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load word book category');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

}