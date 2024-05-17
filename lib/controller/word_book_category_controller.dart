import 'package:get/get.dart';
import 'package:flutter_english_hub/model/WordBookCategory.dart';
import 'package:flutter_english_hub/service/word_book_category_service.dart';

class WordBookCategoryController extends GetxController {
  final WordBookCategoryService wordBookCategoryService = Get.find<WordBookCategoryService>();


  Future<List<WordBookCategory>> fetchWordBookCategory() async {
    var result = await wordBookCategoryService.getWordBookCategory();
    return result;
  }
  
}