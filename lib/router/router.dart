// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:flutter_english_hub/page/home_screen.dart';
import 'package:flutter_english_hub/page/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter_english_hub/page/auth/login.dart';
import 'package:flutter_english_hub/router/router_guard.dart';
import 'package:flutter_english_hub/page/auth/sign_up.dart';
import 'package:flutter_english_hub/page/listening/listening.dart';
import 'package:flutter_english_hub/page/reading/reading.dart';
import 'package:flutter_english_hub/page/writing/writing.dart';
import 'package:flutter_english_hub/page/navigation/home_navigation.dart';
import 'package:flutter_english_hub/page/drawer/feedback_screen.dart';
import 'package:flutter_english_hub/page/drawer/help_screen.dart';
import 'package:flutter_english_hub/page/drawer/invite_friend_screen.dart';

// final List<Map<String, String>> routeList = [
//   // 介绍页面
//   {'name': 'INTRODUCTION', 'route': '/introduction'},
//   // 首页
//   {'name': 'HOME', 'route': '/home'},
//   // 首页导航
//   {'name': 'HOME_NAVIGATION', 'route': '/home_navigation'},
//   // 登录页面
//   {'name': 'LOGIN', 'route': '/login'},
//   // 注册页面
//   {'name': 'SIGN_UP', 'route': '/sign_up'},
//   // 听力页面
//   {'name': 'LISTENING', 'route': '/listening'},
//   // 阅读页面
//   {'name': 'READING', 'route': '/reading'},
//   // 写作页面
//   {'name': 'WRITING', 'route': '/writing'},
//   // 反馈页面
//   {'name': 'FEEDBACK', 'route': '/feedback'},
//   // 帮助页面
//   {'name': 'HELP', 'route': '/help'},
//   // 邀请好友页面
//   {'name': 'INVITE_FRIEND', 'route': '/invite_friend'},
// ];
final List<Map<String, String>> routeList = [
  {'name': 'introduction', 'route': '/introduction'},
  {'name': 'home', 'route': '/home'},
  {'name': 'home_navigation', 'route': '/home_navigation'},
  {'name': 'login', 'route': '/login'},
  {'name': 'sign_up', 'route': '/sign_up'},
  {'name': 'listening', 'route': '/listening'},
  {'name': 'reading', 'route': '/reading'},
  {'name': 'writing', 'route': '/writing'},
  {'name': 'feedback', 'route': '/feedback'},
  {'name': 'help', 'route': '/help'},
  {'name': 'invite_friend', 'route': '/invite_friend'},
];

class Routes {
  static final routes = [
    GetPage(
      name: routeList[0]['route']!,
      page: () => const IntroductionAnimationScreen(),
    ),
    GetPage(
      name: routeList[1]['route']!,
      page: () => MyHomePage(),
    ),
    GetPage(
      name: routeList[2]['route']!,
      page: () => const HomeNavigation(),
    ),
    GetPage(
      name: routeList[3]['route']!,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: routeList[4]['route']!,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: routeList[5]['route']!,
      page: () => ListeningPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: routeList[6]['route']!,
      page: () => ReadingPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: routeList[7]['route']!,
      page: () => WritingPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: routeList[8]['route']!,
      page: () => FeedbackScreen(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: routeList[9]['route']!,
      page: () => HelpScreen(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: routeList[10]['route']!,
      page: () => InviteFriendScreen(),
      middlewares: [RouteAuthMiddleware()],
    ),
  ];
}