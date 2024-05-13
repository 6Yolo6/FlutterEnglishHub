import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:get/get.dart';


class CustomThemePage extends StatelessWidget {
  final List<MaterialColor> colors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Theme'.tr),

      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.changeTheme(
                Get.isDarkMode ? lightTheme : darkTheme
              );
            },
            // 一键切换白天黑夜模式
            child: Text(
              Get.isDarkMode ? 'Day'.tr : 'Night'.tr,
              style: Get.textTheme.displaySmall,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.changeTheme(
                      ThemeData.light().copyWith(
                        primaryColor: colors[index], // 主要部分背景颜色（导航和tabBar等）
                        splashColor: colors[index][100], // 按钮点击时的水波纹颜色
                        appBarTheme: AppBarTheme(
                          systemOverlayStyle: SystemUiOverlayStyle.dark,
                          elevation: 0,
                          backgroundColor: colors[index], // AppBar的背景颜色
                          iconTheme: IconThemeData(color: colors[index][700]), // AppBar的图标颜色
                        ),
                        scaffoldBackgroundColor: colors[index][50], // Scaffold的背景颜色
                        backgroundColor: colors[index][50], // 背景颜色
                        iconTheme: IconThemeData(
                          color: colors[index][700], // 图标颜色
                        ),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          selectedItemColor: colors[index], // 底部导航栏选中项的颜色
                          unselectedItemColor: colors[index][700], // 底部导航栏未选中项的颜色
                        ),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                    );
                  },
                  child: Container(
                    color: colors[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 白天模式
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: Colors.white,
    secondary: Colors.blue, // 替代accentColor
    onPrimary: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    backgroundColor: ThemeData.light().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
  backgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.tealAccent,
    backgroundColor: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.blue, // 选中的Tab的颜色
    unselectedLabelColor: Colors.black, // 未选中的Tab的颜色
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
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
    color: Colors.white,
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.tealAccent,
    unselectedItemColor: Colors.blue,
    backgroundColor: Colors.black,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.tealAccent, // 选中的Tab的颜色
    unselectedLabelColor: Colors.white, // 未选中的Tab的颜色
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    secondary: Colors.tealAccent, // 替代accentColor
    onPrimary: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.tealAccent),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.tealAccent),
    ),
  ),
);
