import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/e_books_controller.dart';
import 'package:flutter_english_hub/page/reading/ebook_series.dart';
import 'package:get/get.dart';

class EBookCategoryPage extends StatefulWidget {
  final int categoryId;

  const EBookCategoryPage({super.key, required this.categoryId});

  @override
  _EBookCategoryPageState createState() => _EBookCategoryPageState();
}

class _EBookCategoryPageState extends State<EBookCategoryPage> with SingleTickerProviderStateMixin {
  final EBooksController _ebooksController = Get.find<EBooksController>();
  

   @override
  void initState() {
    super.initState();
    _ebooksController.getEBookSeriesByCategoryId(widget.categoryId);
  }

  // List<Map<String, dynamic>> getSeriesForCategory(int categoryId) {
  //   // 获取对应分类的系列
  //   return series.where((s) => s['categoryId'] == categoryId).toList();
  // }

  @override
  Widget build(BuildContext context) {
    // final categorySeries = getSeriesForCategory(widget.categoryId);
    // return Scaffold(
    //   // appBar: AppBar(
    //   //   title: Text('系列'),
    //   // ),
    //   body: ListView.builder(
    //     itemCount: categorySeries.length,
    //     itemBuilder: (context, index) {
    //       final seriesItem = categorySeries[index];
    //       return ListTile(
    //         title: Text(seriesItem['name']), // 显示系列名称
    //         onTap: () {
    //           // 导航到该电子书系列
    //           Get.to(
    //               EBookSeries(seriesId: seriesItem['id']),
    //               transition: Transition.fade, duration: const Duration(seconds: 1));
    //         },
    //       );
    //     },
    //   ),
    // );

     return Obx(() {
      if (_ebooksController.isLoadingSeries.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: _ebooksController.ebookSeries.length,
          itemBuilder: (context, index) {
            final seriesItem = _ebooksController.ebookSeries[index];
            return ListTile(
              title: Text(seriesItem.name),
              onTap: () {
                Get.to(() => EBookSeries(seriesId: seriesItem.id));
              },
            );
          },
        );
      }
    });
  }
}

