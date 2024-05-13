import 'dart:async';
import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>> ebooks = [
    {
      'id': 1,
      'title': '疯狂英语口语版 2015 第01期',
      'author': '疯狂英语杂志社',
      'filePath':
          'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb疯狂英语·口语版 2015第01期.pdf',
      'fileType': 'pdf',
      'seriesId': 1,
    },
    {
      'id': 2,
      'title': '疯狂英语口语版 2015 第02期',
      'author': '疯狂英语杂志社',
      'filePath':
      'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/130379844c9b4ebb8022c2cc54269f89疯狂英语·口语版 2015第02期.pdf',
      'fileType': 'pdf',
      'seriesId': 1,
    },
    {
      'id': 3,
      'title': '疯狂英语口语版 2015 第03期',
      'author': '疯狂英语杂志社',
      'filePath':
      'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/3e20bb9abd634740bdb182087ca97604疯狂英语·口语版 2015第03期.pdf',
      'fileType': 'pdf',
      'seriesId': 1,
    },
    {
      'id': 4,
      'title': 'Paul Graham 2006-2023 精选文集（中英对照）',
      'author': 'Paul Graham',
      'filePath': 'https://example.com/epub/paul-graham-2006-2023.epub',
      'fileType': 'epub',
      'seriesId': 3,
    },
    {
      'id': 5,
      'title': '科技博览 2015 第01期',
      'author': '科技博览杂志社',
      'filePath':
          'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb科技博览 2015第01期.pdf',
      'fileType': 'pdf',
      'seriesId': 2,
    },
    {
      'id': 6,
      'title': '商业智慧 2015 第01期',
      'author': '商业智慧杂志社',
      'filePath':
          'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb商业智慧 2015第01期.pdf',
      'fileType': 'pdf',
      'seriesId': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  // 获取对应系列的电子书
  List<Map<String, dynamic>> getEbooksForSeries(int seriesId) {
    return ebooks.where((ebook) => ebook['seriesId'] == seriesId).toList();
  }

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
    final seriesEbooks = getEbooksForSeries(widget.seriesId);

    return Scaffold(
      appBar: AppBar(
        title: Text('电子书系列'),
      ),
      body: ListView.builder(
        itemCount: seriesEbooks.length,
        itemBuilder: (context, index) {
          final ebookItem = seriesEbooks[index];

          if (ebookItem['fileType'] == 'pdf') {
            // 异步获取 PdfDocument
            return FutureBuilder<PdfDocument>(
              future: PdfDocument.openUri(Uri.parse(ebookItem['filePath']!)),
              // 将字符串转换为 Uri
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // 显示加载进度
                }
                if (snapshot.hasError) {
                  return ListTile(
                      title: Text('Error: ${snapshot.error}')); // 错误处理
                }
                final pdfDocument = snapshot.data;
                if (pdfDocument == null) {
                  return ListTile(title: Text('Failed to load PDF')); // 加载失败
                }
                return ListTile(
                  leading: SizedBox(
                    width: 50.0, // 设置一个固定的宽度
                    child: PdfPageView(
                      document: pdfDocument,
                      pageNumber: 1, // 显示第一页缩略图
                      maximumDpi: 300,
                    ),
                  ),

                  // title: Text(ebookItem['title']), // 显示 PDF 标题
                  // // 跳转到 PDF 详情页面
                  // onTap: () {
                  //   Get.to(
                  //     PdfView(
                  //         pdfPath: ebookItem['filePath']!,
                  //         eBookId: ebookItem['id'],
                  //         currentPage:
                  //             _getReadingProgress(ebookItem['id']) as int),
                  //     transition: Transition.fade,
                  //     duration: Duration(seconds: 1),
                  //   );
                  // },

                  title: FutureBuilder<String>(
                    future: _getReadingProgress(ebookItem['id']),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(ebookItem['title']); // 显示 PDF 标题
                      }
                    },
                  ),
                  onTap: () {
                    Get.to(
                      PdfView(
                        pdfPath: ebookItem['filePath']!,
                        eBookId: ebookItem['id'],
                        currentPage: int.parse(snapshot.data! as String),
                      ),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1),
                    );
                  },
                );
              },
            );
          } else if (ebookItem['fileType'] == 'epub') {
            return ListTile(
              // 使用空白图片并显示文本
              leading: SizedBox(
                width: 80.0, // 设置一个固定的宽度
                height: 120.0,
                child: BlankImageWithText(text: ebookItem['title']),
              ),
              title: Text(ebookItem['title'] ?? ''),
              onTap: () async {
                final initialCfi = await _getReadingProgress(ebookItem['id']);
                Get.to(
                  EpubViewer(
                      epubUrl: ebookItem['filePath']!,
                    ebookId: ebookItem['id'],
                    // 传入阅读进度
                    initialCfi: initialCfi),
                  transition: Transition.fade,
                  duration: Duration(seconds: 1),
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}




