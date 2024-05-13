import 'package:flutter_english_hub/model/WordBook.dart';
import 'package:flutter_english_hub/service/word_book_service.dart';
import 'package:get/get.dart';


class WordBookController extends GetxController {
  final WordBookService wordBookService = Get.find<WordBookService>();

  Future<WordBook> fetchWordBook() async {
    var result = await wordBookService.getWordBook();
    return result;
  } 
}