import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class WordReviewService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 获取今日复习单词
  Future<List<WordReview>> fetchTodayWords(int wordBookId, int dailyNewWords, int dailyReviewWords) async {
    final response = await apiService.dio.get(
      'wordReview/getToday',
      queryParameters: {
        'wordBookId': wordBookId,
        'dailyNewWords': dailyNewWords,
        'dailyReviewWords': dailyReviewWords,
      },
    );

    if (response.statusCode == 200) {
      print('今日单词: ${response.data}');
      return (response.data['data'] as List).map((item) => WordReview.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load today words');
    }
  }

  // 更新单词状态
  Future<void> updateWordStatus(int wordId, int wordBookId, int status) async {
    final response = await apiService.dio.post(
      'wordReview/adjust',
      data: {
        'wordId': wordId,
        'wordBookId': wordBookId,
        'status': status,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update word status');
    }
  }
}