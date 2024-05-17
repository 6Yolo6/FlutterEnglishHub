import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_english_hub/model/VideoCategory.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class VideoCategoryService extends GetxService {

  final ApiService apiService = Get.find<ApiService>();

  Future<List<VideoCategory>> getVideoCategory() async {
    try {
      final response = await apiService.dio.get('videoCategory/getAll');

      print('视频类别列表: ${response.data}');
      if (response.data['data'] != null) {
        return (response.data['data'] as List).map((item)
         => VideoCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load word book category');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

}