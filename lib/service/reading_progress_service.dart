import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ReadingProgressService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 保存阅读进度
  Future<bool> saveOrUpdateProgress(int eBookId, String progress) async {
    try {
      final response = await apiService.dio.post(
        'readingProgress/addOrUpdate',
        data: {
          'eBookId': eBookId,
          'progress': progress,
        },
      );
      if (response.statusCode == 200 && response.data['statusCode'] == '200') {
        Get.snackbar('Success', '阅读进度保存成功', backgroundColor: Colors.green);
        return true;
      } else {
        Get.snackbar('Error', 'Error saving progress: ${response.data['message']}', backgroundColor: Colors.red);
        return false;
      }
    } on dio.DioError catch (e) {
      print('Error saving progress: $e');
      return false;
    }
  }

  // 获取阅读进度,参数为电子书ID
  Future<Object> getProgress(int eBookId) async {
    try {
      final response = await apiService.dio.get(
        'readingProgress/get',
        queryParameters: {
          'eBookId': eBookId,
        },
      );
      if (response.statusCode == 200 && response.data['statusCode'] == '200') {
        return response.data;
      } else {
        Get.snackbar('Error', 'Error getting progress: ${response.data['message']}', backgroundColor: Colors.red);
        return 0;
      }
    } on dio.DioError catch (e) {
      print('Error getting progress: $e');
      return 0;
    }
  }
}
