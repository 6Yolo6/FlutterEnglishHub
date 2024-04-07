import 'package:flutter_english_hub/controller/auth_controller.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:flutter_english_hub/service/words_service.dart';

// 通过Get.lazyPut()注册服务
class Service {
  static void init() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => WordsService());
  }
}