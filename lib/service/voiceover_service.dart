import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/model/Voiceover.dart';

class VoiceoverService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 分页获取句子用户配音
  Future<List<Voiceover>> getVoiceover(
      int sentenceId, int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get(
        'voiceovers/getPageBySentenceId',
        queryParameters: {
          'sentenceId': sentenceId,
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      print('句子用户配音列表: ${response.data}');

      List<dynamic> records = response.data['data']['records'];
      List<Voiceover> voiceovers =
          records.map((item) => Voiceover.fromJson(item)).toList();

      return voiceovers;

    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 分页获取我的配音
  Future<List<Voiceover>> getMyVoiceover(int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get(
        'voiceovers/getPageByUserId',
        queryParameters: {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
      print('我的配音列表: ${response.data}');

      List<dynamic> records = response.data['data']['records'];
      List<Voiceover> voiceovers =
          records.map((item) => Voiceover.fromJson(item)).toList();

      return voiceovers;

    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }
}
