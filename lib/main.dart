// 引入flutter框架
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/home_navigation.dart';
// 引入AppTheme类，用于设置应用主题
import 'package:flutter_english_hub/app_theme.dart';
// 引入SystemChrome类，用于设置设备方向
import 'package:flutter/services.dart';
// 引入dart:io库，用于检测平台
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
// 引入get库
import 'package:get/get.dart';
// 引入router
import 'package:flutter_english_hub/router/router.dart';
// 引入storage_service
import 'package:flutter_english_hub/service/storage_service.dart';

// 定义main函数作为应用的入口点
void main() async {
  // 确保Flutter的widget系统初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  // 设置设备的首选方向为纵向
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  // 当设备方向设置完成后，运行MyApp
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // 设置状态栏颜色为透明
      statusBarColor: Colors.transparent,
      // 设置状态栏图标颜色为黑色
      statusBarIconBrightness: Brightness.dark,
      // 设置状态栏亮度为黑色
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      // 设置导航栏颜色为白色
      systemNavigationBarColor: Colors.white,
      // 设置导航栏分隔线颜色为透明
      systemNavigationBarDividerColor: Colors.transparent,
      // 设置导航栏图标颜色为黑色
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    final storageService = Get.find<StorageService>();
    
    return GetMaterialApp(
      title: 'English Hub',
      // 隐藏调试横幅
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        textTheme: AppTheme.textTheme,
        // 设置应用的平台为android
        platform: TargetPlatform.android,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: HomeNavigation(),
      // 初始路由
      // initialRoute: storageService.getToken() == null ? Routes.INTRODUCTION : Routes.HOME,
      // 路由表
      getPages: Routes.routes,
    );
  }
}


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

