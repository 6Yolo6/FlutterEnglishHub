import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>( // 使用GetBuilder来监听状态变化
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value, // 监听selectedIndex的变化
        onTap:(index) {
          controller.changePage(index);
          String currentPage = controller.getCurrentPage();
          print(currentPage);  // 输出当前页面的名称
        }, // 点击时调用NavigationController中的方法
        selectedItemColor: Colors.blue, // 选中时的颜色
        unselectedItemColor: Colors.grey, // 未选中时的颜色
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Hub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'translation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'learning',
          ),
        ],
      ),
    );
  }
}
