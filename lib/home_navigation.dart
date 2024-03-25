import 'package:flutter_english_hub/app_theme.dart';
import 'package:flutter_english_hub/drawer/controller.dart';
import 'package:flutter_english_hub/drawer/home_drawer.dart';
import 'package:flutter_english_hub/sidebar/feedback_screen.dart';
import 'package:flutter_english_hub/sidebar/help_screen.dart';
import 'package:flutter_english_hub/sidebar/home_screen.dart';
import 'package:flutter_english_hub/sidebar/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  Widget? screenView;
  // 当前显示的页面
  DrawerIndex? drawerIndex;
  // 当前选中的抽屉菜单项

  @override
  void initState() {
    // 初始化为首页home
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              // 从抽屉菜单中回调，根据传递的DrawerIndex枚举索引替换屏幕视图
              // 例如：MyHomePage、HelpScreen、FeedbackScreen等...
            },
            // 替换屏幕视图，导航开始屏幕显示：MyHomePage、HelpScreen、FeedbackScreen等...
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  // 根据传递的DrawerIndex枚举索引替换屏幕视图，即当前选中的抽屉菜单项

  // 使用setState的页面跳转方法
  // void changeIndex(DrawerIndex drawerIndexdata) {
  //   if (drawerIndex != drawerIndexdata) {
  //     drawerIndex = drawerIndexdata;
  //     switch (drawerIndex) {
  //       case DrawerIndex.HOME:
  //         setState(() {
  //           screenView = const MyHomePage();
  //         });
  //         break;
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
  //       case DrawerIndex.Invite:
  //         setState(() {
  //           screenView = InviteFriend();
  //         });
  //         break;
  //       default:
  //         break;
  //     }
  //   }
  // }

  // 使用Getx的页面跳转方法
  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          Get.offAll(() => const MyHomePage());
          break;
        case DrawerIndex.Help:
          Get.offAll(() => HelpScreen());
          break;
        case DrawerIndex.FeedBack:
          Get.offAll(() => FeedbackScreen());
          break;
        case DrawerIndex.Invite:
          Get.offAll(() => InviteFriend());
          break;
        default:
          break;
      }
    }
  }
}
