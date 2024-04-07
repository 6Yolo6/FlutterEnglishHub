import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class WordsService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();

  // 根据name模糊分页获取单词
  Future<Object> searchByName(String word, ) async {
    try {
      final response = await apiService.dio.get(
        'word/getByName',
        queryParameters: {
          'word': word,
        },
      );
      print('response: ${response}');
      if (response.statusCode == 200) {
        var data = response.data;
        if (data['statusCode'] == '200') {
          return data['data'];
        }
      }

    } on dio.DioError catch (e) {
      print('e: ${e}');
      return e;
    }
    return {};
  }
}
