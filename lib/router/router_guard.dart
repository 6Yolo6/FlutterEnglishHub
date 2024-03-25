import 'package:get/get.dart';
import 'package:flutter_english_hub/router/router.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:flutter/material.dart';

// 通过GetMiddleware实现路由守卫
class RouteAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 通过Get.find<StorageService>()获取StorageService实例
    final storageService = Get.find<StorageService>();
    if (storageService.getToken() == null) {
      // 如果token为null，重定向到登录页
      return RouteSettings(name: Routes.LOGIN);
    }
    // 否则，允许继续访问目标页
    return null;
  }
}