import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/e_books_controller.dart';
import 'package:flutter_english_hub/page/reading/blank_image_with_text.dart';

import 'package:flutter_english_hub/service/reading_progress_service.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:get/get.dart';

import 'package:flutter_english_hub/page/reading/epub_view.dart';
import 'package:flutter_english_hub/page/reading/pdf_view.dart';

class EBookSeries extends StatefulWidget {
  final int seriesId;

  const EBookSeries({super.key, required this.seriesId});

  @override
  _EBookSeriesState createState() => _EBookSeriesState();
}

class _EBookSeriesState extends State<EBookSeries>
    with SingleTickerProviderStateMixin {
  // 电子书列表
  // List<Map<String, dynamic>> ebooks = [
  //   {
  //     'id': 1,
  //     'title': '疯狂英语口语版 2015 第01期',
  //     'author': '疯狂英语杂志社',
  //     'filePath':
  //         'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb疯狂英语·口语版 2015第01期.pdf',
  //     'fileType': 'pdf',
  //     'seriesId': 1,
  //   },
  //   {
  //     'id': 2,
  //     'title': '疯狂英语口语版 2015 第02期',
  //     'author': '疯狂英语杂志社',
  //     'filePath':
  //     'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/130379844c9b4ebb8022c2cc54269f89疯狂英语·口语版 2015第02期.pdf',
  //     'fileType': 'pdf',
  //     'seriesId': 1,
  //   },
  //   {
  //     'id': 3,
  //     'title': '疯狂英语口语版 2015 第03期',
  //     'author': '疯狂英语杂志社',
  //     'filePath':
  //     'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/3e20bb9abd634740bdb182087ca97604疯狂英语·口语版 2015第03期.pdf',
  //     'fileType': 'pdf',
  //     'seriesId': 1,
  //   },
  //   {
  //     'id': 4,
  //     'title': 'Paul Graham 2006-2023 精选文集（中英对照）',
  //     'author': 'Paul Graham',
  //     'filePath': 'https://example.com/epub/paul-graham-2006-2023.epub',
  //     'fileType': 'epub',
  //     'seriesId': 3,
  //   },
  //   {
  //     'id': 5,
  //     'title': '科技博览 2015 第01期',
  //     'author': '科技博览杂志社',
  //     'filePath':
  //         'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb科技博览 2015第01期.pdf',
  //     'fileType': 'pdf',
  //     'seriesId': 2,
  //   },
  //   {
  //     'id': 6,
  //     'title': '商业智慧 2015 第01期',
  //     'author': '商业智慧杂志社',
  //     'filePath':
  //         'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb商业智慧 2015第01期.pdf',
  //     'fileType': 'pdf',
  //     'seriesId': 3,
  //   },
  // ];

final EBooksController _ebooksController = Get.find<EBooksController>();

  @override
  void initState() {
    super.initState();
    _ebooksController.getEBooksBySeriesId(widget.seriesId);
  }

  // // 获取对应系列的电子书
  // List<Map<String, dynamic>> getEbooksForSeries(int seriesId) {
  //   return ebooks.where((ebook) => ebook['seriesId'] == seriesId).toList();
  // }

  // 获取阅读进度
  Future<String> _getReadingProgress(int ebookId) async {
    final ReadingProgressService readingProgressService =
        Get.find<ReadingProgressService>();
    final progress = await readingProgressService.getProgress(ebookId)
        as Map<String, dynamic>; // 使用类型转换
    print('阅读进度：${progress['progress']}');
    return progress['progress'];
    // 'epubcfi(/6/6[chapter-2]!/4/2/1612)'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('电子书系列'),
      ),
      body: Obx(() {
        if (_ebooksController.isLoadingEBooks.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: _ebooksController.ebooks.length,
            itemBuilder: (context, index) {
              final ebookItem = _ebooksController.ebooks[index];
              if (ebookItem.fileType == 'pdf') {
                // 异步获取 PdfDocument
                return FutureBuilder<PdfDocument>(
                  future: PdfDocument.openUri(Uri.parse(ebookItem.filePath)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return ListTile(title: Text('Error: ${snapshot.error}'));
                    }
                    final pdfDocument = snapshot.data;
                    if (pdfDocument == null) {
                      return ListTile(title: Text('Failed to load PDF'));
                    }
                    return ListTile(
                      leading: SizedBox(
                        width: 50.0,
                        child: PdfPageView(
                          document: pdfDocument,
                          pageNumber: 1,
                          maximumDpi: 300,
                        ),
                      ),
                      title: FutureBuilder<String>(
                        future: _getReadingProgress(ebookItem.id),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(ebookItem.title);
                          }
                        },
                      ),
                      onTap: () {
                        Get.to(
                          PdfView(
                            pdfPath: ebookItem.filePath,
                            eBookId: ebookItem.id,
                            currentPage: int.parse(snapshot.data! as String),
                          ),
                          transition: Transition.fade,
                          duration: Duration(seconds: 1),
                        );
                      },
                    );
                  },
                );
              } else if (ebookItem.fileType == 'epub') {
                return ListTile(
                  leading: SizedBox(
                    width: 80.0,
                    height: 120.0,
                    child: BlankImageWithText(text: ebookItem.title),
                  ),
                  title: Text(ebookItem.title),
                  onTap: () async {
                    final initialCfi = await _getReadingProgress(ebookItem.id);
                    Get.to(
                      EpubViewer(
                        epubUrl: ebookItem.filePath,
                        ebookId: ebookItem.id,
                        initialCfi: initialCfi,
                      ),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1),
                    );
                  },
                );
              } else {
                return Container(); 
              }
            },
          );
        }
      }),
    );
  }
}




