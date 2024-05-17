import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/e_books_controller.dart';
import 'package:flutter_english_hub/controller/words_controller.dart';
import 'package:flutter_english_hub/page/widget/search_overlay.dart';
import 'package:get/get.dart';

import 'package:flutter_english_hub/page/reading/ebook_category.dart';

class EBookPage extends StatefulWidget {
  const EBookPage({super.key});

  @override
  _EBookPageState createState() => _EBookPageState();
}

class _EBookPageState extends State<EBookPage> with SingleTickerProviderStateMixin {
  
  late TabController _tabController;
  final EBooksController _ebooksController = Get.find<EBooksController>();

  // // 分类列表
  // List<Map<String, dynamic>> categories = [
  //   {'id': 1, 'name': '美文'},
  //   {'id': 2, 'name': '幽默'},
  //   {'id': 3, 'name': '诗歌'},
  // ];

  @override
void initState() {
  super.initState();
  _ebooksController.getEBookCategory().then((_) {
    _tabController = TabController(length: _ebooksController.ebookCategories.length, vsync: this);
    setState(() {});
  });
}


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('分类'),
    //     bottom: TabBar(
    //       controller: _tabController,
    //       tabs: categories.map((category) {
    //         return Tab(text: category['name']);
    //       }).toList(),
    //     ),
    //   ),
    //   body: Stack(
    //     children: [
    //       TabBarView(
    //         controller: _tabController,
    //         children: categories.map((category) {
    //           return EBookCategoryPage(categoryId: category['id']);
    //         }).toList(),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
        bottom: _ebooksController.ebookCategories.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                tabs: _ebooksController.ebookCategories.map((category) {
                  return Tab(text: category.name);
                }).toList(),
              ),
      ),
      body: _ebooksController.ebookCategories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: _ebooksController.ebookCategories.map((category) {
                return EBookCategoryPage(categoryId: category.id);
              }).toList(),
            ),
    );
  }
}

