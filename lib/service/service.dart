import 'package:flutter_english_hub/service/api_service.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:get/get.dart';



class Service {
  static void init() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => StorageService());
  }
}