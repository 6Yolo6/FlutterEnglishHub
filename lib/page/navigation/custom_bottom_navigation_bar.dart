import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> with TickerProviderStateMixin  {

  // 动画控制器
  AnimationController? animationController;

  @override
  void initState() {
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
    // 使用GetBuilder来监听状态变化
    return GetBuilder<NavigationController>(
      builder: (controller) => BottomNavyBar(
        // 监听selectedIndex的变化
        // currentIndex: controller.bottomTabController.index,
        // 点击底部导航栏时切换主页面，而不是顶部tab栏
        // onTap:(index) {
        //   controller.bottomTabController.index = index;
        //   controller.changePage(index);
        //   print('当前: $index');
        //   print('当前页面: ${controller.currentPage.value}');
        // },

        selectedIndex: controller.bottomTabController.index,
        showElevation: true, // 是否显示阴影
        onItemSelected: (index) {
          animationController?.reverse().then<dynamic>((data) {
            if (!mounted) {
              return;
            }
            // setState(() {
              controller.bottomTabController.index = index;
              controller.changePage(index, animationController!);
            // });
          });
        },

        // selectedItemColor: Colors.blue, // 选中时的颜色
        // unselectedItemColor: Colors.grey, // 未选中时的颜色
        // items: const [
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.hub),
        //     label: 'Hub',
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.g_translate),
        //     label: 'translation',
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.notes),
        //     label: 'note',
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.book),
        //     label: 'word',
        //   ),
        // ],

        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.hub),
            title: Text('Hub'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.g_translate),
            title: Text('translation'),
            activeColor: Colors.purpleAccent,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.notes),
            title: Text('note'),
            activeColor: Colors.pink,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.book),
            title: Text('word'),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
