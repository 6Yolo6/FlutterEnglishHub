import 'package:flutter_english_hub/model/WordBook.dart';
import 'package:flutter_english_hub/model/WordBooks.dart';
import 'package:flutter_english_hub/service/word_book_service.dart';
import 'package:get/get.dart';

class WordBookController extends GetxController {
  final WordBookService wordBookService = Get.find<WordBookService>();
  final Map<int, RxInt> currentPage = {};

  // 获取单词书数据userId
  Future<WordBook> fetchWordBook() async {
    var result = await wordBookService.getWordBook();
    return result;
  } 

  // 分页获取更多单词书数据categoryId
  Future<List<WordBooks>> fetchWordBooks(int categoryId) async {
    if (!currentPage.containsKey(categoryId)) {
      currentPage[categoryId] = 1.obs;
    }
    var result = await wordBookService.getPageByCategoryId(categoryId, currentPage[categoryId]!.value, 8);
    currentPage[categoryId]!.value++;
    return result;
  }

  // 刷新单词书数据
  Future<List<WordBooks>> refreshWordBooks(int categoryId) async {
    currentPage[categoryId] = 1.obs;
    var result = await wordBookService.getPageByCategoryId(categoryId, currentPage[categoryId]!.value, 8);
    currentPage[categoryId]!.value++;
    return result;
  }

  // 根据categoryId获取单词书列表
  Future<List<WordBooks>> getWordBooksByCategoryId(int categoryId) async {
    var result = await wordBookService.getWordBooksByCategoryId(categoryId);
    return result;
  }
}
