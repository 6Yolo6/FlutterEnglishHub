import 'package:flutter/material.dart';
import 'package:flutter_english_hub/page/reading/ebook_series.dart';
import 'package:get/get.dart';

class EBookCategory extends StatefulWidget {
  final int categoryId;

  const EBookCategory({super.key, required this.categoryId});

  @override
  _EBookCategoryState createState() => _EBookCategoryState();
}

class _EBookCategoryState extends State<EBookCategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 系列列表
  List<Map<String, dynamic>> series = [
    {'id': 1, 'name': '疯狂英语口语版', 'categoryId': 1},
    {'id': 2, 'name': '科技博览', 'categoryId': 2},
    {'id': 3, 'name': '商业智慧', 'categoryId': 3},

  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: series.length, vsync: this);
  }

  List<Map<String, dynamic>> getSeriesForCategory(int categoryId) {
    // 获取对应分类的系列
    return series.where((s) => s['categoryId'] == categoryId).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categorySeries = getSeriesForCategory(widget.categoryId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('系列'),
      // ),
      body: ListView.builder(
        itemCount: categorySeries.length,
        itemBuilder: (context, index) {
          final seriesItem = categorySeries[index];
          return ListTile(
            title: Text(seriesItem['name']), // 显示系列名称
            onTap: () {
              // 导航到该电子书系列
              Get.to(
                  EBookSeries(seriesId: seriesItem['id']),
                  transition: Transition.fade, duration: const Duration(seconds: 1));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EBookSeries(seriesId: seriesItem['id']),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}

