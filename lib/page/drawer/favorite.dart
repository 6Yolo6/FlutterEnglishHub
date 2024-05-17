import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/page/drawer/favor/favor_daily_sentence.dart';
import 'package:flutter_english_hub/page/widget/post_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with TickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> favorList = [
    {'id': 1, 'name': '一句'},
    {'id': 2, 'name': '听力'},
    {'id': 3, 'name': '阅读'},
    {'id': 4, 'name': '口语'},
    {'id': 5, 'name': '其他'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: favorList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
        actions: [
          IconButton(
            onPressed: () {
              print("通知按钮被点击");
            },
            icon: Icon(Icons.notifications_none),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: favorList.map((favor) => Tab(text: favor['name'])).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: favorList.map((favor) => Favor(favorId: favor['id'])).toList(),
      ),
    );
  }
}

class Favor extends StatelessWidget {
  final int favorId;

  const Favor({Key? key, required this.favorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildContentForId(favorId);  // 直接返回内容
  }

  Widget buildContentForId(int id) {
    switch (id) {
      case 1:
        return const FavorDailySentence();  // 这个组件应该自己处理滚动
      case 3:
        // return ListView.builder(
        //   itemCount: 6,
        //   itemBuilder: (context, index) => const PostCard(),
        // );
      default:
        return Container();  // 为其他情况提供默认空容器
    }
  }
}

