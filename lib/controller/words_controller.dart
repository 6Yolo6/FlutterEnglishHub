import 'package:flutter_english_hub/service/words_service.dart';
import 'package:get/get.dart';

class WordsController extends GetxController {
  final WordsService wordsService = Get.find<WordsService>();

  // 根据name模糊分页获取单词
  Future<Object> searchByName(String word, int pageNum, int pageSize) async {
    try {
      final response = await wordsService.searchByName(word, pageNum, pageSize);
      return response;
    } catch (e) {
      print('e: ${e}');
      return e;
    }
  }

  // 清除单词搜索历史记录
  void clearSearchHistory() {
    try {
      wordsService.clearSearchHistory();
    } catch (e) {
      print('e: ${e}');
    }
  }

  // 获取单词搜索历史记录
  Future<Object> getSearchHistory() async {
    try {
      final response = await wordsService.getSearchHistory();
      return response;
    } catch (e) {
      print('e: ${e}');
      return e;
    }
  }
}
