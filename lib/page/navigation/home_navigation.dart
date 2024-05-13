import 'package:flutter_english_hub/main.dart';
import 'package:flutter_english_hub/page/drawer/custom_language.dart';
import 'package:flutter_english_hub/page/drawer/favorite.dart';
import 'package:flutter_english_hub/page/navigation/custom_bottom_navigation_bar.dart';
import 'package:flutter_english_hub/page/drawer/custom_theme.dart';
import 'package:flutter_english_hub/controller/home_drawer_controller.dart';
import 'package:flutter_english_hub/page/drawer/home_drawer.dart';
import 'package:flutter_english_hub/page/drawer/feedback_screen.dart';
import 'package:flutter_english_hub/page/drawer/help_screen.dart';
import 'package:flutter_english_hub/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation>
    with SingleTickerProviderStateMixin {
  Widget? screenView;
  // 当前显示的页面
  DrawerIndex? drawerIndex;
  // 当前选中的抽屉菜单项
  // 动画控制器
  AnimationController? animationController;

  @override
  void initState() {
    // 初始化为首页home
    // drawerIndex = DrawerIndex.HOME;
    screenView = MyHomePage();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Get.theme.colorScheme.background,
        child: SafeArea(
          // 是否受屏幕UI影响
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Get.theme.colorScheme.background,
            body: HomeDrawerController(
              screenIndex: drawerIndex,
              // 抽屉宽度设置为屏幕宽度的0.75
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
                // 从抽屉菜单中回调，根据传递的DrawerIndex枚举索引替换屏幕视图
              },
              // 替换屏幕视图
              screenView: screenView,
            ),
            // 底部导航栏
            // bottomNavigationBar: const CustomBottomNavigationBar(),
          ),
        ),
      ),
      // 底部导航栏
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  // 根据传递的DrawerIndex枚举索引替换屏幕视图，即当前选中的抽屉菜单项
  // void changeIndex(DrawerIndex drawerIndexdata) {
  //   if (drawerIndex != drawerIndexdata) {
  //     drawerIndex = drawerIndexdata;
  //     switch (drawerIndex) {
  //       case DrawerIndex.Help:
  //         setState(() {
  //           screenView = HelpScreen();
  //         });
  //         break;
  //       case DrawerIndex.FeedBack:
  //         setState(() {
  //           screenView = FeedbackScreen();
  //         });
  //         break;
  //       case DrawerIndex.ForgettingCurve:
  //         setState(() {
  //           screenView = ForgettingCurveScreen();
  //         });
  //         break;
  //       default:
  //         break;
  //     }
  //   }
  // }

  // 使用Getx的页面跳转方法

  void changeIndex(DrawerIndex drawerIndexdata) {
    // if (drawerIndex != drawerIndexdata) {
    drawerIndex = drawerIndexdata;
    switch (drawerIndex) {
      case DrawerIndex.Help:
        Get.to(() => HelpScreen(),
            transition: Transition.fade, duration: Duration(seconds: 1));
        break;
      case DrawerIndex.FeedBack:
        Get.to(() => FeedbackScreen(),
            transition: Transition.fade, duration: Duration(seconds: 1));
        break;
      case DrawerIndex.ChangeTheme:
        Get.to(() => CustomThemePage(),
            transition: Transition.fade, duration: Duration(seconds: 1));
        break;
        case DrawerIndex.ChangeLanguage:
        Get.to(() => CustomLanguagePage(),
            transition: Transition.fade, duration: Duration(seconds: 1));
      case DrawerIndex.Favorite:
        Get.to(() => FavoritePage(),
            transition: Transition.fade, duration: Duration(seconds: 1));
      default:
        break;
    }
    // }
  }
}
