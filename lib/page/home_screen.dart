import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_english_hub/main.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/page/gridview.dart';
import 'package:flutter_english_hub/page/listening/listening.dart';
import 'package:flutter_english_hub/page/reading/reading.dart';
import 'package:flutter_english_hub/page/navigation/custom_bottom_navigation_bar.dart';
import 'package:flutter_english_hub/page/spoken/spoken.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 控制器
  final NavigationController _navigationController =
      Get.find<NavigationController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // // 设置是否显示全局悬浮按钮为true
    // Get.find<MyApp>().setShouldShowFloatingButton(true, context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(), // 顶部AppBar

            Expanded(
              // 主体部分
              child: FutureBuilder<bool>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return TabBarView(
                      controller: _navigationController.topTabController,
                      children: [
                        GridViewPage(), // 首页
                        ListeningPage(), // 听力
                        ReadingPage(), // 阅读
                        SpokenPage(), // 口语
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // // 底部导航栏
      // bottomNavigationBar: const CustomBottomNavigationBar(),
      // 浮动按钮
    );
  }

  Widget appBar() {
    return SizedBox(
      // 顶部AppBar高度，
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 1),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: TabBar(
              controller: _navigationController.topTabController,
              tabs: [
                Tab(text: "Home".tr),
                Tab(text: "Listening".tr),
                Tab(text: "Reading".tr),
                Tab(text: "Speaking".tr),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 跳转到搜索页面
              print('点击顶部搜索');
            },
          ),
        ],
      ),
    );
  }
}
