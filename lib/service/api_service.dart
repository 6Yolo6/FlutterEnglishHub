// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/storage_service.dart';


class ApiService {
  final Dio dio = Dio();

  void showFeedback(String type, String message, Color backgroundColor) {
    Get.snackbar(type, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }
  
  ApiService() {
    dio
      // ..options.baseUrl = 'http://localhost:8899/englishhub/'
      // pdcn2
      ..options.baseUrl = 'http://192.168.1.237:8899/englishhub/'
      // 垃圾桶
      // ..options.baseUrl = 'http://192.168.43.119:8899/englishhub/'
      ..interceptors.add(InterceptorsWrapper(
        // 请求拦截器
        onRequest: (options, handler) async {
          final storageService = Get.find<StorageService>();
        String? token = storageService.getToken();
        // print('token: $token');
        if (token != null) {
          options.headers["token"] = token;
        }
        return handler.next(options);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          // 返回结果中的data字段
          print('请求结果: $response');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print('请求错误: $e');
          // 401错误码表示token过期,清除token,跳转到登录页
          if (e.response?.statusCode == 401) {
            Get.find<StorageService>().clearToken();
            showFeedback('', 'token过期，请重新登录', Colors.red);
            Get.offAllNamed('/login');
          }
        },
      ));
  }
}
