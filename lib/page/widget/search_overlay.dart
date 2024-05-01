

// 搜索框组件
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/words_controller.dart';
import 'package:get/get.dart';

class SearchOverlay extends StatefulWidget {

  final OverlayEntry overlayEntry;

  SearchOverlay(this.overlayEntry);

  @override
  SearchOverlayState createState() => SearchOverlayState();

}

class SearchOverlayState extends State<SearchOverlay> {
  final WordsController _wordsController = Get.find<WordsController>();

  final TextEditingController _controller = TextEditingController();
  // 静态测试数据
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
                              _wordsController.clearSearchHistory();
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
    var wordsList = _wordsController.searchByName(query, 1, 10);
    print('wordsList: $wordsList');
  }
}

