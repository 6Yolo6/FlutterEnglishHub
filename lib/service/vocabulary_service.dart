
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class VocabularyService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 根据用户ID获取生词本数据
  Future<List<WordReview>> getVocabularyByUser() async {
    try {
      final response = await apiService.dio.get(
        'vocabularyBook/getByUser'
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((item) => WordReview.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load vocabulary');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
