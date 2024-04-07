// ignore_for_file: unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:flutter_english_hub/router/router.dart';
import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:flutter/material.dart';

// 通过GetMiddleware实现路由守卫
class RouteAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 通过authService判断token是否有效
    final AuthService authService = Get.find<AuthService>();
    authService.validate();
    print('authService.isAuthenticated.value: ${authService.isAuthenticated.value}');
    if (!authService.isAuthenticated.value) {
      // 重定向到登录页
      return RouteSettings(name: Routes.login);
    }
    // 否则，允许继续访问目标页
    return null;
  }
}