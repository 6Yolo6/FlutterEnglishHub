import 'package:flutter_english_hub/model/Word.dart';
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/service/word_service.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  final WordService wordService = Get.find<WordService>();

  var currentPage = 1.obs;
  

  // 清除单词搜索历史记录
  void clearSearchHistory() {
    try {
      wordService.clearSearchHistory();
    } catch (e) {
      print('e: ${e}');
    }
  }

  // // 获取单词搜索历史记录
  // Future<List<WordReview>> getSearchHistory() async {
  //   final result = await wordService.getSearchHistory();
  //   return result;
  // }

  // 获取单词搜索历史记录
  Future<List<WordReview>> getSearchHistory() async {
    final result = await wordService.getSearchHistory();
    return result;
  }


  // 根据wordBookId获取单词分页数据
  Future<List<Word>> getByWordBookId(int wordBookId) {
    var result = wordService.getByWordBookId(wordBookId, currentPage.value, 15);
    currentPage.value++;
    return result;
  }

  // 根据name模糊获取单词list15条
  Future<List<WordReview>> searchByName(String word) async {
    final result = await wordService.searchByName(word);
    return result;
  }
}