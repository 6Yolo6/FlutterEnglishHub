import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_hub/controller/custom_theme_controller.dart';
import 'package:get/get.dart';

class CustomThemePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Switcher'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.find<CustomThemeController>().toggleTheme();
            print('Switch Theme');
          },
          child: Text('Switch Theme'),
        ),
      ),
    );
  }
}

// 白天模式
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,// 主要部分背景颜色（导航和tabBar等）
  splashColor: Colors.white12,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    backgroundColor: ThemeData.light().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
  backgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.red,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.tealAccent
  ),
);

// 夜间模式
ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
  backgroundColor: Colors.black,
  iconTheme: const IconThemeData(
    color: Colors.blue,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.tealAccent,
      unselectedItemColor: Colors.blue
  ),
);
