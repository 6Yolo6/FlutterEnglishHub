import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/word_controller.dart';
import 'package:flutter_english_hub/model/Word.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class WordListPage extends StatefulWidget {
  final int wordBookId;

  const WordListPage({Key? key, required this.wordBookId}) : super(key: key);

  @override
  _WordListPageState createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late WordController wordController = Get.find<WordController>();
  // 单词列表
  List<Word> words = [];

  // 用于记录每个单词的释义是否展开
  List<bool> expanded = [];

  // 用于记录是否显示所有单词的解释
  bool showAllDefinitions = false;

  // 用于记录是否显示音标
  bool showPhonetics = true;

  // 用于记录是否显示释义
  bool showDefinitions = true;

  @override
  void initState() {
    super.initState();
  loadWords();

  }
Future<void> _loadMoreWords() async {
  List<Word> loadedWords = await wordController.getByWordBookId(widget.wordBookId);
  print('更多数据：$loadedWords');
  if (mounted) { 
    setState(() {
      words.addAll(loadedWords);
      expanded.addAll(List.generate(loadedWords.length, (index) => false));
    });
  }
  _refreshController.loadComplete();
}

  Future<void> loadWords() async {
    List<Word> loadedWords = await wordController.getByWordBookId(widget.wordBookId);
    setState(() {
      words.addAll(loadedWords);
      expanded.addAll(List.generate(loadedWords.length, (index) => false));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单词列表 (${words.length})'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // 搜索按钮
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 显示搜索框
              showSearch(
                // 上下文
                context: context,
                // 搜索框代理
                delegate: WordSearchDelegate(
                  words,
                  showDefinitions: showDefinitions,
                  showPhonetics: showPhonetics,
                  onWordTap: (word) {
                    final index = words.indexWhere((element) => element.word == word);
                    if (index != -1) {
                      setState(() {
                        expanded[index] = !expanded[index];
                      });
                    }
                  },
                ),
              );
            },
          ),
          // 设置按钮
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // 右上角小弹窗
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(500, 80, 0, 0),
                items: [
                  PopupMenuItem(
                      child: Text('全部显示解释'),
                      // 点击切换所有单词释义的展开/收起状态
                      onTap: () {
                        setState(() {
                          showAllDefinitions = !showAllDefinitions;
                          expanded = List.generate(
                              words.length, (index) => showAllDefinitions);
                        });
                      }),
                  PopupMenuItem(
                    child: Text('解释设置'),
                    onTap: () {
                      // 弹出底部弹窗
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('显示释义'),
                                trailing:
                                GFToggle(
                                  onChanged: (value) {
                                    setState(() {
                                      showDefinitions = value!;
                                    });
                                  },
                                  value: showDefinitions,
                                  type: GFToggleType.custom,
                                  enabledText: 'On',
                                  disabledText: 'Off',
                                  enabledThumbColor: Colors.blue,
                                  enabledTrackColor: Colors.blue.shade100,
                                ),

                              ),
                              ListTile(
                                title: Text('显示音标'),
                                trailing:
                                GFToggle(
                                  onChanged: (value) {
                                    setState(() {
                                      showPhonetics = value!;
                                    });
                                  },
                                  value: showPhonetics,
                                  type: GFToggleType.custom,
                                  enabledText: 'On',
                                  disabledText: 'Off',
                                  enabledThumbColor: Colors.blue,
                                  enabledTrackColor: Colors.blue.shade100,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: _refreshController,
      onLoading: _loadMoreWords,
      child: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(words[index].word),
            trailing: Icon(Icons.info_outline),
            // 点击展开/收起释义
            onTap: () {
              setState(() {
                expanded[index] = !expanded[index];
              });
            },
            subtitle: expanded[index]
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showPhonetics)
                        Row(
                          children: [
                            Text(words[index].phoneticUk),
                            Text(' / '),
                            Text(words[index].phoneticUs),
                          ],
                        ),
                      if (showDefinitions) Text(words[index].definition),
                    ].whereType<Widget>().toList(),
                  )
                : null,
          );
        },
      ),
      ),
    );
  }
}

// 搜索框代理，继承自SearchDelegate，用于实现搜索功能
class WordSearchDelegate extends SearchDelegate<String> {
  final List<Word> words;
  final Function(String) onWordTap;
  final bool showDefinitions;
  final bool showPhonetics;

  WordSearchDelegate(this.words, {required this.showDefinitions,
    required this.showPhonetics, required this.onWordTap});

  // 搜索框右侧的清除按钮
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  // 搜索框左侧的返回按钮
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  // 搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  // 搜索建议，模糊匹配单词
  @override
Widget buildSuggestions(BuildContext context) {
  // 模糊匹配单词，大小写不敏感
  List<Word> matchQuery = words
      .where((word) => word.word.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return ListView.builder(
    itemCount: matchQuery.length,
    itemBuilder: (context, index) {
      final word = matchQuery[index];
      return ListTile(
        title: Text(word.word),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(word.phoneticUk), // 美音标
            // Text(word.phoneticUs), // 英音标
            // // Text(word.definition), // 释义
            // if (isExpanded) Text(word.definition),
              if (showPhonetics) Text(word.phoneticUk),
              if (showPhonetics) Text(word.phoneticUs),
              if (showDefinitions) Text(word.definition),
          ],
        ),
        onTap: () {
          // 匹配到的单词，query为用户输入的搜索词
          // query = word.word;
          // 点击单词回调，切换单词释义的展开/收起状态
          // onWordTap(query);
          // 显示搜索结果
          // showResults(context);
          // 点击单词，切换对应的释义显示状态
          onWordTap(word.word);
        },
      );
    },
  );
}
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // 模糊匹配单词，大小写不敏感
  //   List<String> matchQuery = words
  //       .where((word) => word.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   // for (var word in words) {
  //   //   if (word.toLowerCase().contains(query.toLowerCase())) {
  //   //     matchQuery.add(word);
  //   //   }
  //   // }
  //   return ListView.builder(
  //     itemCount: matchQuery.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(matchQuery[index]),
  //         onTap: () {
  //           // 匹配到的单词，query为用户输入的搜索词
  //           query = matchQuery[index];
  //           // 点击单词回调，切换单词释义的展开/收起状态
  //           onWordTap(query);
  //           // 显示搜索结果
  //           // showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
