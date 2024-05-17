
import 'package:flutter_english_hub/model/NewsHotwords.dart';
import 'package:flutter_english_hub/service/news_hotwords_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NewsHotwordsController extends GetxController {
  final NewsHotwordsService newsHotwordsService = Get.find<NewsHotwordsService>();
  var hotwordsList = <NewsHotwords>[].obs;
  var isLoading = false.obs;
  var pageNum = 1.obs;
  var pageSize = 10.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    fetchHotwords();
    super.onInit();
  }

  Future<void> fetchHotwords() async {
    if (isLoading.value || !hasMore.value) return;

    try {
      isLoading(true);
      var hotwords = await newsHotwordsService.getPage(pageNum.value, pageSize.value);
      if (hotwords.length < pageSize.value) {
        hasMore(false);
      }
      hotwordsList.addAll(hotwords);
      pageNum.value++;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshHotwords() async {
    try {
      isLoading(true);
      pageNum.value = 1;
      hasMore(true);
      var hotwords = await newsHotwordsService.getPage(pageNum.value, pageSize.value);
      hotwordsList.assignAll(hotwords);
      if (hotwords.length < pageSize.value) {
        hasMore(false);
      }
      pageNum.value++;
    } finally {
      isLoading(false);
    }
  }
}
