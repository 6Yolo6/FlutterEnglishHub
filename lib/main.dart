// 引入flutter框架
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/international/translate.dart';
import 'package:flutter_english_hub/page/widget/search_overlay.dart';
import 'package:flutter_english_hub/page/navigation/home_navigation.dart';
import 'package:flutter_english_hub/service/storage_service.dart';

// 引入AppTheme类，用于设置应用主题

// 引入SystemChrome类，用于设置设备方向
import 'package:flutter/services.dart';

// 引入dart:io库，用于检测平台
import 'package:flutter_english_hub/page/drawer/custom_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 引入get库
import 'package:get/get.dart';

// 引入get_storage库
import 'package:get_storage/get_storage.dart';

// 引入router
import 'package:flutter_english_hub/router/router.dart';

// 引入Service
import 'package:flutter_english_hub/service/service.dart';

// 引入可拖动浮动按钮
import 'package:flutter_english_hub/page/widget/draggable_floating_button.dart';
// 引入下拉刷新库
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 定义main函数作为应用的入口点
void main() async {
  // 确保Flutter的widget系统初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化GetStorage
  await GetStorage.init();
  // 初始化Service，使用Get.lazyPut()方法来延迟加载服务
  await Service.init();
  Get.find<StorageService>().saveIsFirstTime(false);
  final isFirstTime = Get.find<StorageService>().getIsFirstTime() ?? true;
  // 更新标志位isFirstTime
  Get.put(MyApp(isFirstTime: isFirstTime));
  // 初始化MediaKit
  // MediaKit.ensureInitialized();
  // 设置设备的首选方向为纵向
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp(
        isFirstTime: isFirstTime,
      )));
}

class MyApp extends StatelessWidget {
  // 是否是第一次打开应用
  final bool isFirstTime;
  // 定义全局悬浮按钮的OverlayEntry
  late OverlayEntry floatingButtonEntry;
  // 是否已添加全局悬浮按钮
  bool isFloatingButtonAdded = false;
  // 是否显示全局悬浮按钮
  bool shouldShowFloatingButton = true;

  MyApp({super.key, required this.isFirstTime}) {
    // 在应用程序启动时初始化全局悬浮按钮
    floatingButtonEntry = OverlayEntry(
      builder: (context) => DraggableFloatingButton(
        onTap: () => _showSearchOverlay(context),
      ),
    );
  }

  void _showSearchOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => SearchOverlay(overlayEntry),
    );
    overlay.insert(overlayEntry);
  }

  void setShouldShowFloatingButton(bool value, BuildContext context) {
    shouldShowFloatingButton = value;
    updateFloatingButton(context);
  }

  void updateFloatingButton(BuildContext context) {
    final overlay = Overlay.of(context);
    if (shouldShowFloatingButton && !isFloatingButtonAdded) {
      Future.delayed(Duration.zero, () {
        overlay.insert(floatingButtonEntry);
        isFloatingButtonAdded = true;
      });
    } else if (!shouldShowFloatingButton && isFloatingButtonAdded) {
      floatingButtonEntry.remove();
      isFloatingButtonAdded = false;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => MaterialClassicHeader(), // 配置默认头部指示器
      footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
      headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
      springDescription:
          SpringDescription(stiffness: 170, damping: 16, mass: 1.9), // 自定义回弹动画
      maxOverScrollExtent: 100, // 头部最大可以拖动的范围
      maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
      enableScrollWhenRefreshCompleted: true, // 这个属性不兼容PageView和TabBarView
      enableLoadingWhenFailed: true, // 在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        builder: (context, widget) => GetMaterialApp(
          localizationsDelegates: [
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN'),
          ],
          title: 'English Hub',
          debugShowCheckedModeBanner: false,
          // 设置初始语言为英语
          locale: Locale('en', 'US'), 
          // locale: Locale('zh', 'CN'),
          translations: Translate(),
          theme: lightTheme,
          // theme: darkTheme,
          home: Builder(
            builder: (context) {
              setShouldShowFloatingButton(true, context);
              return const HomeNavigation();
            },
          ),
          initialRoute: Routes.introduction,
          getPages: Routes.routes,
        ),
      ),
    );

    // 设置状态栏样式
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   // 设置状态栏颜色为透明
    //   statusBarColor: Colors.transparent,
    //   // 设置状态栏图标颜色为黑色
    //   statusBarIconBrightness: Brightness.dark,
    //   // 设置状态栏亮度为黑色
    //   statusBarBrightness:
    //       !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
    //   // 设置导航栏颜色为白色
    //   systemNavigationBarColor: Colors.white,
    //   // 设置导航栏分隔线颜色为透明
    //   systemNavigationBarDividerColor: Colors.transparent,
    //   // 设置导航栏图标颜色为黑色
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));

    // return ScreenUtilInit(
    //   designSize: Size(360, 690),
    //   builder: (context, widget) => GetMaterialApp(
    // // return GetMaterialApp(
    //   title: 'English Hub',
    //   // 隐藏调试横幅
    //   debugShowCheckedModeBanner: false,
    //   locale: Locale('en', 'US'), // 设置初始语言为英语
    //   translations: Translate(),

    // theme: ThemeData(
    //   // textTheme: AppTheme.textTheme,
    //   // 设置应用的平台为android
    //   platform: TargetPlatform.android,
    //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //   // useMaterial3: true,
    // ),

    //   theme: lightTheme,

    //   home: Builder(
    //     builder: (context) {
    //       setShouldShowFloatingButton(true, context);
    //       return const HomeNavigation();
    //     },
    //   ),
    //   // 根据 isFirstTime 判断初始路由
    //   // initialRoute: isFirstTime ? Routes.introduction : Routes.homeNavigation,
    //   initialRoute: Routes.introduction,
    //     // 路由表
    //   getPages: Routes.routes,
    // ),
    // );
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
