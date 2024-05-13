import 'package:flutter_english_hub/controller/auth_controller.dart';
import 'package:flutter_english_hub/controller/daily_sentence_controller.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/controller/voiceover_controller.dart';
import 'package:flutter_english_hub/controller/word_book_controller.dart';
import 'package:flutter_english_hub/controller/words_controller.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:flutter_english_hub/service/daily_sentence_service.dart';
import 'package:flutter_english_hub/service/reading_progress_service.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:flutter_english_hub/service/voiceover_service.dart';
import 'package:flutter_english_hub/service/word_book_service.dart';
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
    Get.lazyPut(() => DailySentenceController());
    Get.lazyPut(() => VoiceoverController(), fenix: true);
    Get.lazyPut(() => VoiceoverService());
    Get.lazyPut(() => WordBookController());
    Get.lazyPut(() => WordBookService());
  }
}