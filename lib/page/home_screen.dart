import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
// 导入浮动按钮组件
import 'package:flutter_english_hub/model/draggable_floating_button.dart';
// 导入wordsController
import 'package:flutter_english_hub/controller/words_controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final NavigationController _navigationController = Get.find<NavigationController>();
  final WordsController _wordsController = Get.find<WordsController>();

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

  void _showSearchOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _SearchOverlay(_wordsController, overlayEntry),
    );
  
    overlay.insert(overlayEntry);  // 弹出搜索框
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: Stack( // 使用Stack组件来包含可拖动按钮
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                appBar(), // 顶部AppBar
                Expanded( // 主体部分
                  child: FutureBuilder<bool>(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return TabBarView(
                          controller: _navigationController.tabController,
                          children: [
                            const GridViewPage(), // 首页
                            ListeningPage(), // 听力
                            const ReadingPage(), // 阅读
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
          // 浮动按钮
          DraggableFloatingButton(onTap: () => _showSearchOverlay(context)), 
        ],
      ),
      // 底部导航栏
      bottomNavigationBar: const CustomBottomNavigationBar(),
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

// 搜索框组件
class _SearchOverlay extends StatefulWidget {
  final WordsController wordsController;
  final OverlayEntry overlayEntry;

  _SearchOverlay(this.wordsController, this.overlayEntry);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<_SearchOverlay> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _searchHistory = ['apple', 'banana', 'orange', 'pear', 'grape', 'watermelon', 'strawberry', 'cherry', 'mango', 'pineapple'];
  // final List<String> _searchHistory = [];
  final FocusNode _focusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.overlayEntry.remove(); // 点击空白处关闭搜索框
      },
      child: Material(
        color: Colors.transparent, // 透明背景，确保点击事件可以穿透
        child: Align(
          alignment: Alignment.topCenter, // 定格在顶部
          child: FractionallySizedBox(
            widthFactor: 1, // 宽度占满屏幕
            // 高度占比，由搜索历史列表高度动态计算
            heightFactor: _searchHistory.length > 5 ? 0.6 : _searchHistory.length * 0.1 + 0.07,
            child: Container(
              // 背景颜色与 Tab 栏一致
              color: Colors.blue[400], 
              // 顶部内边距5
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 7),
              child: Column(
                // 主轴从上到下，交叉轴从左到右
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 顶部搜索框
                  Container(
                    // 与 Tab 栏高度一致
                    height: 40, 
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person, color: Colors.white),
                          onPressed: () {
                            widget.overlayEntry.remove(); // 关闭搜索框
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode, // 设置焦点
                            autofocus: true, // 自动聚焦
                            decoration: const InputDecoration(
                              hintText: '请输入要搜索的单词或词组',
                              border: InputBorder.none, // 无边框
                            ),
                            textAlignVertical: TextAlignVertical.center, // 垂直居中
                            textInputAction: TextInputAction.search, // 设置回车为搜索
                            onSubmitted: (value) {
                              _search(value); // 回车触发搜索
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic,
                              color: Colors.white), // 语音图标
                          onPressed: () {
                            // 语音识别逻辑
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.search,
                              color: Colors.white), // 搜索图标
                          onPressed: () {
                            _search(_controller.text); // 搜索图标点击触发搜索
                          },
                        ),
                      ],
                    ),
                  ),
                  // 搜索历史标题
                  if (_searchHistory.isNotEmpty) ...[
                    Container(
                      // 顶部内边距
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('单词搜索历史',
                              style: TextStyle(color: Colors.black)), // 标题
                          TextButton(
                            onPressed: () {
                              // 清除搜索历史
                              widget.wordsController.clearSearchHistory();
                              setState(() {}); // 刷新界面
                            },
                            child: const Text('全部删除',
                                style: TextStyle(color: Colors.black)), // 全部删除
                          ),
                          TextButton(
                            onPressed: () {
                              // 关闭搜索历史列表
                               _searchHistory.clear(); 
                               setState(() {
                                 
                               });
                            },
                            child: const Text('关闭',
                                style: TextStyle(color: Colors.black)), 
                          ),
                        ],
                      ),
                    ),
                    // 搜索历史列表
                    Expanded(
                      child: Material(
                        // type: MaterialType.transparency,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: _searchHistory.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_searchHistory[index]),
                              onTap: () {
                                _search(_searchHistory[index]); // 点击历史项进行搜索
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _search(String query) {
    var wordsList = widget.wordsController.searchByName(query, 1, 10);
    print('wordsList: $wordsList');
  }
}