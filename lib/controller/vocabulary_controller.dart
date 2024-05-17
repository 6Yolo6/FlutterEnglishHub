import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_english_hub/service/vocabulary_service.dart';
import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:get/get.dart';

class VocabularyController extends GetxController {
  final VocabularyService vocabularyService = Get.find<VocabularyService>();
  final AuthService authService = Get.find<AuthService>();
  var vocabularyList = <WordReview>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVocabulary();
  }

  Future<void> fetchVocabulary() async {
    try {
      isLoading(true);
      var vocabularies = await vocabularyService.getVocabularyByUser();
      vocabularyList.value = vocabularies;
    } finally {
      isLoading(false);
    }
  }
}
