import 'package:get/get.dart';
import 'package:flutter_english_hub/sidebar/home_screen.dart';
import 'package:flutter_english_hub/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter_english_hub/login/login.dart';
import 'package:flutter_english_hub/router/router_guard.dart';

class Routes {
  static const INTRODUCTION = '/introduction';
  static const HOME = '/home';
  static const LOGIN = '/login';

  static final routes = [
    GetPage(
      // 介绍动画页面
      name: INTRODUCTION,
      page: () => IntroductionAnimationScreen(),
    ),
    GetPage(
      // 首页
      name: HOME,
      page: () => const MyHomePage(),
      // 路由守卫
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      // 登录页
      name: LOGIN,
      page: () => Login(),
    ),
  ];
}