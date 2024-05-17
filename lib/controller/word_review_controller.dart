import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/service/word_review_service.dart';
import 'package:get/get.dart';

class WordReviewController extends GetxController {
  final WordReviewService wordBookService = Get.find<WordReviewService>();

  Future<List<WordReview>> fetchTodayWords(int wordBookId, int dailyNewWords, int dailyReviewWords) async {
    // 获取今日需要学习的单词
    return await wordBookService.fetchTodayWords(wordBookId, dailyNewWords, dailyReviewWords);
  }

  Future<void> updateWordStatus(int wordId, int wordBookId, int status) async {
    // 更新单词状态
    await wordBookService.updateWordStatus(wordId, wordBookId, status);
  }
}
