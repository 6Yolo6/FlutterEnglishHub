import 'package:flutter/material.dart';
import 'package:flutter_english_hub/model/WordInfo.dart';
import 'package:getwidget/getwidget.dart';

class WordListPage extends StatefulWidget {
  final int wordBookId;

  const WordListPage({Key? key, required this.wordBookId}) : super(key: key);

  @override
  _WordListPageState createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  // 单词列表
  List<WordInfo> words = [];

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
    loadWords().then((loadedWords) {
      setState(() {
        words = loadedWords;
        // 默认所有单词释义都是收起状态
        expanded = List.generate(words.length, (index) => false);
      });
    });
  }

 Future<List<WordInfo>> loadWords() async {
  // 发送 HTTP 请求
  // final response = await http.get('http://your-backend.com/words');

  // 检查响应状态码
  // if (response.statusCode == 200) {
  //   // 如果服务器返回 200 OK，解析响应体为 JSON
  //   List<dynamic> responseBody = json.decode(response.body);

  //   // 将 JSON 数组转换为单词对象列表
    

  //   return words;
  // } else {
  //   // 如果响应状态码不是 200，抛出异常
  //   throw Exception('Failed to load words');
  // }

  // 测试数据WordInfo
  List<WordInfo> words = [
    WordInfo(
      word: 'abandon',
      phoneticUk: 'əˈbændən',
      phoneticUs: 'əˈbændən',
      definition: 'v. 放弃；抛弃；离弃；遗弃',
    ),
    WordInfo(
      word: 'abbreviation',
      phoneticUk: 'əˌbri:viˈeɪʃn',
      phoneticUs: 'əˌbri:viˈeɪʃn',
      definition: 'n. 缩写；缩略；缩写词',
    ),
    WordInfo(
      word: 'abolish',
      phoneticUk: 'əˈbɒlɪʃ',
      phoneticUs: 'əˈbɑ:lɪʃ',
      definition: 'v. 废除；废止；取消；革除',
    ),
    WordInfo(
      word: 'abolition',
      phoneticUk: 'ˌæbəˈlɪʃn',
      phoneticUs: 'ˌæbəˈlɪʃn',
      definition: 'n. 废除；废止；废除运动',
    ),
    WordInfo(
      word: 'abort',
      phoneticUk: 'əˈbɔ:t',
      phoneticUs: 'əˈbɔ:rt',
      definition: 'v. 流产；中止；夭折；使中止',
    ),
    WordInfo(
      word: 'abortion',
      phoneticUk: 'əˈbɔ:ʃn',
      phoneticUs: 'əˈbɔ:ʃn',
      definition: 'n. 流产；堕胎；失败；夭折',
    ),
    WordInfo(
      word: 'above',
      phoneticUk: 'əˈbʌv',
      phoneticUs: 'əˈbʌv',
      definition: 'prep. 在…之上；高于；超过；在…上面',
    ),
    WordInfo(
      word: 'abreast',
      phoneticUk: 'əˈbrest',
      phoneticUs: 'əˈbrest',
      definition: 'adv. 并列；并排；并肩',
    ),
    WordInfo(
      word: 'abroad',
      phoneticUk: 'əˈbrɔ:d',
      phoneticUs: 'əˈbrɔ:d',
      definition: 'adv. 在国外；到国外；在传播；在流传',
    ),
    WordInfo(
      word: 'abrupt',
      phoneticUk: 'əˈbrʌpt',
      phoneticUs: 'əˈbrʌpt',
      definition: 'adj. 突然的；唐突的；陡峭的；生硬的',
    ),
  ];
  return words;
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
      body: ListView.builder(
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
                      showPhonetics ? Text('/ɪɡˈzæmpəl/') : null,
                      showDefinitions ? Text('n. 例子；样品；实例') : null,
                    ].whereType<Widget>().toList(),
                  )
                : null,
          );
        },
      ),
    );
  }
}

// 搜索框代理，继承自SearchDelegate，用于实现搜索功能
class WordSearchDelegate extends SearchDelegate<String> {
  final List<WordInfo> words;
  final Function(String) onWordTap;

  WordSearchDelegate(this.words, {required this.onWordTap});

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
  List<WordInfo> matchQuery = words
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
            Text(word.phoneticUk), // 美音标
            Text(word.phoneticUs), // 英音标
            Text(word.definition), // 释义
          ],
        ),
        onTap: () {
          // 匹配到的单词，query为用户输入的搜索词
          query = word.word;
          // 点击单词回调，切换单词释义的展开/收起状态
          onWordTap(query);
          // 显示搜索结果
          // showResults(context);
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
