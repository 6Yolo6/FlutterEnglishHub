import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/service/storage_service.dart';


class ApiService {
  final Dio dio = Dio();
  
  ApiService() {
    dio
      ..options.baseUrl = 'http://localhost:8899/englishhub/'
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storageService = Get.find<StorageService>();
        String? token = storageService.getToken();
        // print('token: $token');
        if (token != null) {
          options.headers["token"] = token;
          // 添加跨域相关的头
          // options.headers["Access-Control-Allow-Origin"] = "*";
          // options.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE";
          // options.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization";
        }
        return handler.next(options);
        },
      ));
  }
}