

// 搜索框组件
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/word_controller.dart';
import 'package:flutter_english_hub/controller/words_controller.dart';
import 'package:flutter_english_hub/model/Word.dart';
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class SearchOverlay extends StatefulWidget {

  final OverlayEntry overlayEntry;

  SearchOverlay(this.overlayEntry);

  @override
  SearchOverlayState createState() => SearchOverlayState();

}

class SearchOverlayState extends State<SearchOverlay> {

  final WordController _wordController = Get.find<WordController>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<WordReview> _searchResults = [];
  List<WordReview> _searchHistory = [];
  bool _isLoading = false;
  late AudioPlayer _audioPlayer;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _controller.addListener(_onSearchChanged);
    _fetchSearchHistory();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(_controller.text);
    });
  }

  Future<void> _fetchSearchHistory() async {
    List<WordReview> history = await _wordController.getSearchHistory();
    setState(() {
      _searchHistory = history;
      print('搜索历史：$_searchHistory');
    });
  }
  
   void _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    List<WordReview> wordsList = await _wordController.searchByName(query);
    if (mounted) {
      setState(() {
        _searchResults = wordsList;
        print('搜索结果：$_searchResults');
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _debounce?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

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
            // 高度占比，由搜索结果列表高度动态计算
            heightFactor: _searchResults.length > 5 ? 0.6 : _searchResults.length * 0.1 + 0.15,
            // heightFactor: _searchResults.isNotEmpty ? 0.6 : 0.2, // 动态计算高度
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
                            onPressed: () async {
                              // 清除搜索历史
                              _wordController.clearSearchHistory();
                              setState(() {
                                _searchHistory.clear();
                              }); // 刷新界面
                            },
                            child: const Text('全部删除',
                                style: TextStyle(color: Colors.black)), // 全部删除
                          ),
                          TextButton(
                            onPressed: () {
                              // 关闭搜索历史列表
                              _searchHistory.clear();
                              setState(() {});
                            },
                            child: const Text('关闭',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    // 搜索历史列表
                    Flexible(
                      child: Material(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: _searchHistory.length,
                          itemBuilder: (context, index) {
                            final word = _searchHistory[index];
                            return ListTile(
                              title: Text(word.word),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    if (word.phoneticUk!='')
                                      TextSpan(text: 'UK: ${word.phoneticUk}, '),
                                    if (word.phoneticUs!='')
                                      TextSpan(text: 'US: ${word.phoneticUs}'),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  if (word.audioUrl == null || word.audioUrl!.isEmpty) {
                                    Get.snackbar('', '暂无发音');
                                  } else {
                                    _audioPlayer.play(UrlSource(word.audioUrl!));
                                  }
                                },
                              ),
                              onTap: () {
                                _search(word.word);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                    // 搜索结果列表
                  if (_isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (_searchResults.isNotEmpty)
                    Flexible(
                      child: Material(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final word = _searchResults[index];
                            return ListTile(
                              title: Text(word.word),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    if (word.phoneticUk != '')
                                      TextSpan(text: 'UK: ${word.phoneticUk}, '),
                                    if (word.phoneticUs != '')
                                      TextSpan(text: 'US: ${word.phoneticUs}'),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  if (word.audioUrl == null || word.audioUrl!.isEmpty) {
                                    Get.snackbar('', '暂无发音');
                                  } else {
                                    _audioPlayer.play(UrlSource(word.audioUrl!));
                                  }
                                },
                              ),
                              onTap: () {
                                _search(word.word);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

