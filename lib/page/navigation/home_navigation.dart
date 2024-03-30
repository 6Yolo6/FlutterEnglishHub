import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:flutter_english_hub/controller/home_drawer_controller.dart';
import 'package:flutter_english_hub/page/drawer/home_drawer.dart';
import 'package:flutter_english_hub/page/drawer/feedback_screen.dart';
import 'package:flutter_english_hub/page/drawer/help_screen.dart';
import 'package:flutter_english_hub/page/home_screen.dart';
import 'package:flutter_english_hub/page/drawer/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    screenView = MyHomePage();
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
          body: HomeDrawerController(
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
        // case DrawerIndex.HOME:
        //   Get.to(() => MyHomePage());
        //   break;
        case DrawerIndex.Help:
          Get.to(() => HelpScreen());
          break;
        case DrawerIndex.FeedBack:
          Get.to(() => FeedbackScreen());
          break;
        case DrawerIndex.Invite:
          Get.to(() => InviteFriendScreen());
          break;
        default:
          break;
      }
    }
  }
}
