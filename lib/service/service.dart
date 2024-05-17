import 'package:flutter_english_hub/controller/articles_controller.dart';
import 'package:flutter_english_hub/controller/auth_controller.dart';
import 'package:flutter_english_hub/controller/daily_sentence_controller.dart';
import 'package:flutter_english_hub/controller/e_books_controller.dart';
import 'package:flutter_english_hub/controller/learning_plans_controller.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/controller/news_hotwords_controller.dart';
import 'package:flutter_english_hub/controller/user_controller.dart';
import 'package:flutter_english_hub/controller/video_category_controller.dart';
import 'package:flutter_english_hub/controller/videos_controller.dart';
import 'package:flutter_english_hub/controller/vocabulary_controller.dart';
import 'package:flutter_english_hub/controller/voiceover_controller.dart';
import 'package:flutter_english_hub/controller/word_book_category_controller.dart';
import 'package:flutter_english_hub/controller/word_book_controller.dart';
import 'package:flutter_english_hub/controller/word_controller.dart';
import 'package:flutter_english_hub/controller/word_review_controller.dart';
import 'package:flutter_english_hub/controller/words_controller.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:flutter_english_hub/service/articles_service.dart';
import 'package:flutter_english_hub/service/daily_sentence_service.dart';
import 'package:flutter_english_hub/service/e_books_service.dart';
import 'package:flutter_english_hub/service/learning_plans_service.dart';
import 'package:flutter_english_hub/service/news_hotwords_service.dart';
import 'package:flutter_english_hub/service/reading_progress_service.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:flutter_english_hub/service/video_category_service.dart';
import 'package:flutter_english_hub/service/videos_service.dart';
import 'package:flutter_english_hub/service/vocabulary_service.dart';
import 'package:flutter_english_hub/service/voiceover_service.dart';
import 'package:flutter_english_hub/service/word_book_category_service.dart';
import 'package:flutter_english_hub/service/word_book_service.dart';
import 'package:flutter_english_hub/service/word_review_service.dart';
import 'package:flutter_english_hub/service/word_service.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:flutter_english_hub/service/words_service.dart';


// 通过Get.lazyPut()注册服务
class Service {
  static Future<void> init() async {
    // 添加 fenix: true 参数，会强制重新创建
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => StorageService());
    // 这个方法会异步地初始化一个AuthService对象，并等待它的init方法完成
    await Get.putAsync(() => AuthService().init());
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => WordsService());
    Get.lazyPut(() => WordsController(), fenix: true);
    Get.lazyPut(() => ReadingProgressService());
    Get.lazyPut(() => DailySentenceService());
    Get.lazyPut(() => DailySentenceController(), fenix: true);
    Get.lazyPut(() => VoiceoverController(), fenix: true);
    Get.lazyPut(() => VoiceoverService());
    Get.lazyPut(() => WordBookController(), fenix: true);
    Get.lazyPut(() => WordBookService());
    Get.lazyPut(() => WordController(), fenix: true);
    Get.lazyPut(() => WordService());
    Get.lazyPut(() => WordBookCategoryController(), fenix: true);
    Get.lazyPut(() => WordBookCategoryService());
    Get.lazyPut(() => WordReviewController(), fenix: true);
    Get.lazyPut(() => WordReviewService());
    Get.lazyPut(() => VideosController(), fenix: true);
    Get.lazyPut(() => VideosService());
    Get.lazyPut(() => VideoCategoryController(), fenix: true);
    Get.lazyPut(() => VideoCategoryService());
    Get.lazyPut(() => ArticlesController(), fenix: true);
    Get.lazyPut(() => ArticlesService());
    Get.lazyPut(() => EBooksController(), fenix: true);
    Get.lazyPut(() => EBooksService());
    Get.lazyPut(() => NewsHotwordsController(), fenix: true);
    Get.lazyPut(() => NewsHotwordsService());
    Get.lazyPut(() => LearningPlansController(), fenix: true);
    Get.lazyPut(() => LearningPlansService());
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => VocabularyController(), fenix: true);
    Get.lazyPut(() => VocabularyService());
  }
}