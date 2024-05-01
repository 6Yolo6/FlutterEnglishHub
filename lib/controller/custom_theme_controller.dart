import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // 主题状态
  Rx<ThemeData> _theme = ThemeData.light().obs;

  // 获取当前主题
  ThemeData get theme => _theme.value;

  // 切换主题
  void toggleTheme() {
    if (_theme.value == ThemeData.light()) {
      _theme.value = ThemeData.dark();
    } else {
      _theme.value = ThemeData.light();
    }
  }
}