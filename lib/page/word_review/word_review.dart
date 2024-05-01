import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 用于状态管理和路由

class VocabularyBookPage extends StatefulWidget {
  @override
  _VocabularyBookPageState createState() => _VocabularyBookPageState();
}

class _VocabularyBookPageState extends State<VocabularyBookPage> {
  final TextEditingController _searchController = TextEditingController(); // 搜索框控制器
  final List<String> _categories = ['四级', '六级', '考研']; // 分类标签
  final Map<String, List<VocabularyBook>> _books = {
    '四级': [
      VocabularyBook('CET 4 英语词汇', '2607词', 'assets/cet4_vocab.png'),
      VocabularyBook('CET 4 考前必刷词', '1116词', 'assets/cet4_essential.png'),
      VocabularyBook('CET 4 考前急救词包', '193词', 'assets/cet4_quick.png'),
    ],
    '六级': [
      // 示例
    ],
    '考研': [
      // 示例
    ],
  };

  String _selectedCategory = '四级'; // 默认选择的分类

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加单词本'), // 页面标题
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40), // 搜索框高度
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索单词书', // 搜索框提示
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.search), // 搜索图标
              ),
              onChanged: (value) {
                setState(() {
                  // 当搜索内容改变时，可以添加搜索逻辑
                });
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCategoryTabs(), // 构建分类标签栏
          Expanded(child: _buildVocabularyBookList()), // 构建单词书列表
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return TabBar(
      isScrollable: true, // 标签可左右滑动
      onTap: (index) {
        setState(() {
          _selectedCategory = _categories[index]; // 更新选中的分类
        });
      },
      tabs: _categories.map((category) => Tab(text: category)).toList(), // 构建标签
    );
  }

  Widget _buildVocabularyBookList() {
    return ListView.builder(
      itemCount: _books[_selectedCategory]!.length,
      itemBuilder: (context, index) {
        var book = _books[_selectedCategory]![index];
        return ListTile(
          leading: Image.asset(book.imagePath), // 自定义图片
          title: Text(book.name), // 单词书名称
          subtitle: Text(book.wordCount), // 单词数量
          onTap: () => _showLearningPlanDialog(book), // 点击单词书显示弹窗
        );
      },
    );
  }

  void _showLearningPlanDialog(VocabularyBook book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('设置学习计划'), // 弹窗标题
          content: Text('设置每天背单词的数量'), // 弹窗内容
          actions: [
            TextButton(
              onPressed: () {
                // 确定学习计划逻辑
                Navigator.pop(context); // 关闭弹窗
              },
              child: Text('确定'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), // 取消按钮
              child: Text('取消'),
            ),
          ],
        );
      },
    );
  }
}

// 单词书类
class VocabularyBook {
  final String name; // 单词书名称
  final String wordCount; // 单词数量
  final String imagePath; // 自定义图片路径

  VocabularyBook(this.name, this.wordCount, this.imagePath);
}
