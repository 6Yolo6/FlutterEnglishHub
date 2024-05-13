// ignore_for_file: constant_identifier_names

import 'package:flutter_english_hub/page/daily_sentence/daily_sentence_list.dart';
import 'package:flutter_english_hub/page/drawer/favorite.dart';
import 'package:flutter_english_hub/page/reading/article.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/page/home_screen.dart';
import 'package:flutter_english_hub/page/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter_english_hub/page/auth/login.dart';
import 'package:flutter_english_hub/page/auth/sign_up.dart';
import 'package:flutter_english_hub/page/listening/listening.dart';
import 'package:flutter_english_hub/page/reading/reading.dart';
import 'package:flutter_english_hub/page/writing/writing.dart';
import 'package:flutter_english_hub/page/navigation/home_navigation.dart';
import 'package:flutter_english_hub/page/drawer/feedback_screen.dart';
import 'package:flutter_english_hub/page/drawer/help_screen.dart';
import 'package:flutter_english_hub/page/drawer/forgetting_curve_screen.dart';
import 'package:flutter_english_hub/page/translation/translation.dart';
import 'package:flutter_english_hub/page/word_review/word_review.dart';

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

class Routes {
  // 介绍页面
  static String introduction = '/introduction';

  // 首页
  static String home = '/home';

  // 首页导航
  static String homeNavigation = '/home_navigation';

  // 登录页面
  static String login = '/login';

  // 注册页面
  static String signUp = '/sign_up';

  // 听力页面
  static String listening = '/listening';

  // 阅读页面
  static String reading = '/reading';

  // 写作页面
  static String writing = '/writing';

  // 反馈页面
  static String feedback = '/feedback';

  // 帮助页面
  static String help = '/help';

  // 遗忘曲线页面
  static String forgettingCurve = '/forgetting_curve';

  // 翻译页面
  static String translation = '/translation';

  // 学习单词
  static String wordReview = '/word_review';

  // 新闻页面
  static String article = '/article';

  // 收藏页面
  static String favorite = '/favorite';

  // 每日一句列表
  static String dailySentenceList = '/daily_sentence_list';

  static final routes = [
    GetPage(
      name: Routes.introduction,
      page: () => const IntroductionAnimationScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => MyHomePage(),
    ),
    GetPage(
      name: Routes.homeNavigation,
      page: () => const HomeNavigation(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: Routes.listening,
      page: () => ListeningPage(),
    ),
    GetPage(
      name: Routes.reading,
      page: () => ReadingPage(),
    ),
    GetPage(
      name: Routes.writing,
      page: () => WritingPage(),
    ),
    GetPage(
      name: Routes.feedback,
      page: () => FeedbackScreen(),
    ),
    GetPage(
      name: Routes.help,
      page: () => HelpScreen(),
    ),
    GetPage(
      name: Routes.forgettingCurve,
      page: () => const ForgettingCurveScreen(),
    ),
    GetPage(
      name: Routes.translation,
      page: () => TranslationPage(),
    ),
    GetPage(
      name: Routes.wordReview,
      page: () => WordReviewPage(),
    ),
    GetPage(
      name: Routes.article,
      page: () => const ArticlePage(),
    ),
    GetPage(
      name: Routes.favorite,
      page: () => const FavoritePage(),
    ),
    GetPage(
      name: Routes.dailySentenceList,
      page: () => const DailySentenceList(),
    ),
  ];
}
