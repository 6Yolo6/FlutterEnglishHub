import 'package:flutter_english_hub/model/user.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class AuthService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();
  // 存储当前登录用户信息
  var user = Rxn<User>();
  // 监听登录状态
  RxBool isAuthenticated = false.obs;


  void showFeedback(String type, String message, Color backgroundColor) {
    Get.snackbar(type, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }

  // 登录接口
  Future<bool> loginService(String username, String password) async {
    try {
      final response = await apiService.dio.post(
        'user/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      print('response: ${response}');
      print('response.data: ${response.data}');
      print('response.statusCode: ${response.statusCode}');
      print('response.data["statusCode"]: ${response.data['statusCode']}');
      // success
      if (response.statusCode == 200) {
        var data = response.data;
        String? dataStatusCode = data['statusCode'];
        // 600错误码表示用户名或密码错误
        if (dataStatusCode == '600') {
          String message = data['message'];
          showFeedback('登录', 'Login failed: $message', Colors.red);
          return false;
        } else if (dataStatusCode == '200') {
          String? token = data['data']['token'];
          if (token != null) {
            // 保存token
            Get.find<StorageService>().saveToken(token);
            // 将返回json数据转换为User对象，并存储
            user.value = User.fromJson(data['data']['user']);
            Get.find<StorageService>().saveUser(user.value!.toJson());
            showFeedback('登录', 'Login successful', Colors.green);
            return true;
          }
        }
      }
    } on dio.DioError catch (e) {
      // DioError中会包含后端返回的实际statusCode和数据
      if (e.response != null) {
        print('Error statusCode: ${e.response!.statusCode}');
        print('Error response data: ${e.response!.data}');
        // 其他错误
        showFeedback('登录', 'Login failed: Unknown error', Colors.red);
      } else {
        // Error without response data
        showFeedback('登录', 'Login failed: Error occurred', Colors.red);
      }
    }
    return false;
  }

  // 注册接口
  Future<bool> registerService(String username, String password) async {
    try {
      final response = await apiService.dio.post(
        'user/register',
        data: {
          'username': username,
          'password': password,
        },
      );
      print('response: ${response}');
      // success
      if (response.statusCode == 200) {
        var data = response.data;
        String? dataStatusCode = data['statusCode'];
        // 400错误码表示用户名已存在
        if (dataStatusCode == '400') {
          String message = data['message'];
          showFeedback('注册', '用户名已存在: $message', Colors.red);
          return false;
        } else if (dataStatusCode == '200') {
          showFeedback('注册', 'Register successful', Colors.green);
          return true;
        }
      }
    } on dio.DioError catch (e) {
      // DioError中会包含后端返回的实际statusCode和数据
      if (e.response != null) {
        print('Error statusCode: ${e.response!.statusCode}');
        print('Error response data: ${e.response!.data}');
        // 其他错误
        showFeedback('注册', 'Register failed: Unknown error', Colors.red);
      } else {
        // Error without response data
        showFeedback('注册', 'Register failed: Error occurred', Colors.red);
      }
    }
    return false;
  }

  // 验证token是否有效
  Future<void> validate() async {
    try {
      final response = await apiService.dio.get('user/validate');
      if (response.statusCode == 200) {
        var data = response.data;
        String? dataStatusCode = data['statusCode'];
        if (dataStatusCode == '200') {
          isAuthenticated.value = true;
        } else if (dataStatusCode == '400')  {
          // token无效
          showFeedback('', 'token无效，请重新登录', Colors.red);
          isAuthenticated.value = false;
        }
      }
    } on dio.DioError catch (e) {
      if (e.response != null) {
        print('Error statusCode: ${e.response!.statusCode}');
        print('Error response data: ${e.response!.data}');
      }
      isAuthenticated.value = false;
    }
    print('是否已登录: ${isAuthenticated.value}');
  }
}
