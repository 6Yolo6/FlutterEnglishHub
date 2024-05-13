import 'package:flutter_english_hub/page/word_review/word_review.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/router/router.dart';


class NavigationController extends GetxController with SingleGetTickerProviderMixin {
  // 定义selectedIndex变量，用于记录当前选中的底部导航栏索引
  var selectedIndex = 0.obs;
  // 存储当前页面的名称
  RxString currentPage = 'home'.obs;
  // // tab栏控制器
  // late TabController tabController;
  // 定义两个TabController
  late TabController topTabController;
  late TabController bottomTabController;
  late AnimationController animationController;


  @override
  void onInit() {
    super.onInit();
    topTabController = TabController(length: 4, vsync: this);
    bottomTabController = TabController(length: 5, vsync: this);
    animationController = AnimationController(vsync: this);
  }


  // 点击底部导航栏时调用的方法
  void changePage(int index, AnimationController animationController) {
    selectedIndex.value = index;
    update(); 
    // 使用Getx的路由跳转
    if (index == 0) {
      // 主页
      Get.to(Routes.routes[2].page(), transition: Transition.fade, duration: Duration(seconds: 1));
    } else if (index == 1) {
      // 翻译
      // Get.offNamed(Routes.routes[11].name);
      Get.to(Routes.routes[11].page(), transition: Transition.fade, duration: Duration(seconds: 1));
    } else if (index == 2) {
      // 生词本，笔记
      // Get.to(NotePage(), transition: Transition.fade, duration: Duration(seconds: 1));
      Get.to(Routes.routes[13].page(), transition: Transition.fade, duration: Duration(seconds: 1));
    } else if (index == 3) {
      // 跳转学习单词页面，传animationController参数
      Get.to(() => WordReviewPage(animationController: animationController), transition: Transition.fade, duration: Duration(seconds: 1));
      // Get.to(Routes.routes[12].page(), transition: Transition.fade, duration: Duration(seconds: 1));
    }
  }


  // 判断是否显示底部导航栏
  bool shouldShowBottomNavigationBar() {
    // print("当前页面: ${currentPage.value}");
    if (currentPage.value == 'login' || currentPage.value == 'sign_up') {
      return false;
     }
    return true;
  }

  @override
  void onClose() {
    topTabController.dispose();
    bottomTabController.dispose();
    super.onClose();
  }

  String getCurrentPage() {
    return currentPage.value;
  }
}
