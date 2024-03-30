import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/model/homelist.dart';
import 'package:flutter_english_hub/page/gridview.dart';
import 'package:flutter_english_hub/page/listening/listening.dart';
import 'package:flutter_english_hub/page/reading/reading.dart';
import 'package:flutter_english_hub/page/navigation/custom_bottom_navigation_bar.dart';
import 'package:flutter_english_hub/page/spoken/spoken.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  final NavigationController _navigationController = Get.find<NavigationController>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _navigationController.selectedIndex.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _navigationController.tabController,
          tabs: const [
            Tab(text: "首页"),
            Tab(text: "听力"),
            Tab(text: "阅读"),
            Tab(text: "口语"),
            Tab(text: "其他"), // 根据你的需要定义Tab
          ],
        ),
      ),
      body: TabBarView(
        controller: _navigationController.tabController,
        children: <Widget>[
          // 第一个页面是GridView展示HomeList
          const GridViewPage(),
          // 听力页面
          ListeningPage(),
          // 阅读页面
          ReadingPage(),
          // 口语页面
          SpokenPage(),
          // 其他页面
          
          // 
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

