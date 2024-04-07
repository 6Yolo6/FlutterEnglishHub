import 'package:flutter/material.dart';
import 'package:flutter_english_hub/page/drawer/home_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/model/homelist.dart';
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
            // 顶部AppBar
            appBar(),
            // 占满剩余空间
            Expanded(
              // 异步加载数据
              child: FutureBuilder<bool>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return TabBarView(
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
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
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
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: TabBar(
              controller: _navigationController.tabController,
              tabs: const [
                Tab(text: "首页"),
                Tab(text: "听力"),
                Tab(text: "阅读"),
                Tab(text: "口语"),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 跳转到搜索页面
            },
          ),
        ],
      ),
    );
  }
}
