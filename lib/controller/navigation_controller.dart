import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/router/router.dart';


class NavigationController extends GetxController with SingleGetTickerProviderMixin {
  // 定义selectedIndex变量，用于记录当前选中的底部导航栏索引
  var selectedIndex = 0.obs;
  // 存储当前页面的名称
  RxString currentPage = 'home'.obs;
  // 添加一个新的变量来标记是否正在显示介绍动画
  // RxBool isInIntroAnimation = false.obs;
  // tab栏控制器
  late TabController tabController;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this); 
  }

  // 点击底部导航栏时调用的方法
  void navigateTo(String pageName) {
    currentPage.value = pageName;
    update();
  }

  // 点击底部导航栏时调用的方法
  void changePage(int index) {
    selectedIndex.value = index;
    update(); 
    // 使用Getx的路由跳转
    if (index == 0) {
      Get.offNamed(Routes.homeNavigation);
    } else if (index == 1) {
      Get.offNamed(Routes.translation);
    } else if (index == 2) {
      // Get.offNamed(Routes().note);
    } else if (index == 3) {
      // Get.offNamed(Routes().word);
    }
  }

  // void startIntroAnimation() {
  //   isInIntroAnimation.value = true;
  //   update();
  // }

  // void endIntroAnimation() {
  //   isInIntroAnimation.value = false;
  //   update();
  // }

  // 判断是否显示底部导航栏
  bool shouldShowBottomNavigationBar() {
    if (currentPage.value == 'login' || currentPage.value == 'sign_up') {
      return false;
     } //else if (isInIntroAnimation.value) {
    //   return false;
    // }
    return true;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  String getCurrentPage() {
    return currentPage.value;
  }
}
