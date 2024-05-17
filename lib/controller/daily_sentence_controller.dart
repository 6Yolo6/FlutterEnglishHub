
import 'package:flutter_english_hub/model/DailySentence.dart';
import 'package:flutter_english_hub/service/daily_sentence_service.dart';
import 'package:get/get.dart';

class DailySentenceController extends GetxController {
  final DailySentenceService dailySentenceService = Get.find<DailySentenceService>();
  var currentPage = 1.obs;


  // 刷新每日一句
  Future<List<DailySentence>> refreshDailySentences() async {
    currentPage.value = 1;
    var result = await dailySentenceService.getDailySentence(currentPage.value, 5);
    currentPage.value++;
    return result;
  }

  // 分页获取每日一句
  Future<List<DailySentence>> fetchDailySentences() async {
    var result = await dailySentenceService.getDailySentence(currentPage.value, 5);
    currentPage.value++;
    return result;
  }
}