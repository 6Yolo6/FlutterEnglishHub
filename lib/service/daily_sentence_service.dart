import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_english_hub/model/DailySentence.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class DailySentenceService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();
  
  // 分页获取每日一句
  Future<List<DailySentence>> getDailySentence(int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get(
        'dailySentences/getPage',
        queryParameters: {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      print('每日一句列表: ${response.data}');
      if (response.data != null && response.data['data'] != null && response.data['data']['records'] != null) {
        return (response.data['data']['records'] as List).map((item) => DailySentence.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load daily sentences');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 根据日期获取每日一句
  // Future<DailySentence> getDailySentenceByDate(String date) async {
    
  // }
  
}