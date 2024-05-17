import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class LearningPlansService  extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 新增或更新学习计划
  Future<bool> saveOrUpdateLearningPlan(int worBookId, int dailyNewWords, int dailyReviewWords, String endDate) async {
    try {
      final response = await apiService.dio.post(
        'learningPlans/saveOrUpdate',
        data: {
          'worBookId': worBookId,
          'dailyNewWords': dailyNewWords,
          'dailyReviewWords': dailyReviewWords,
          'endDate': endDate,
        },
      );
      if (response.statusCode == 200 && response.data['statusCode'] == '200') {
        Get.snackbar('Success', '学习计划保存成功', backgroundColor: Colors.green);
        return true;
      } else {
        Get.snackbar('Error', 'Error saving learning plan: ${response.data['message']}', backgroundColor: Colors.red);
        return false;
      }
    } on dio.DioError catch (e) {
      print('Error saving learning plan: $e');
      return false;
    }
  }
}