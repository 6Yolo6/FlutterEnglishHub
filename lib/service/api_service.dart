import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/service/storage_service.dart';


class ApiService {
  final Dio dio = Dio();
  
  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storageService = Get.find<StorageService>();
        String? token = await storageService.getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    ));
  }
}