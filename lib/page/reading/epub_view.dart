import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/reading_progress_service.dart';
import 'package:epub_view/epub_view.dart'; // EPUB 阅读器
import 'package:dio/dio.dart';

import 'package:get/get.dart'; // 用于路由和状态管理

class EpubViewer extends StatefulWidget {
  final String epubUrl; // EPUB文件的网络地址
  final String initialCfi; // 初始Cfi，用于从上次查看位置开始
  final int ebookId; // 电子书ID

  const EpubViewer({
    Key? key,
    required this.epubUrl,
    required this.initialCfi,
    required this.ebookId,
  }) : super(key: key);

  @override
  _EpubViewerState createState() => _EpubViewerState();
}

class _EpubViewerState extends State<EpubViewer> {
  late EpubController _epubController; // EPUB控制器
  String? _currentCfi; // 当前Cfi
  final ReadingProgressService readingProgressService = Get.find<ReadingProgressService>();

  @override
  void initState() {
    super.initState();
    _loadEpub(); // 加载EPUB文件
  }

  void _loadEpub() async {
    try {
      final dio = Dio();
      // 发送 GET 请求获取文件内容
      final response = await dio.get(widget.epubUrl, options: Options(responseType: ResponseType.bytes));
      final data = response.data;
      _epubController = EpubController(
        document: EpubDocument.openData(data), // 加载 EPUB
        epubCfi: widget.initialCfi, // 初始 Cfi
      );
    } catch (e) {
      print('加载 EPUB 文件时发生错误: $e'); // 错误处理
    }
  }

  @override
  void dispose() {
    super.dispose();
    _currentCfi = _epubController.generateEpubCfi(); // 获取当前Cfi
    _saveReadingProgress(); // 保存阅读进度
  }

  void _saveReadingProgress() async {
    final success = await readingProgressService.saveOrUpdateProgress(
      widget.ebookId,
      _currentCfi!,
    );

    if (success) {
      print('EPUB 阅读进度保存成功。');
    } else {
      print('EPUB 阅读进度保存失败。');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_epubController == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('EPUB Viewer'),
        ),
        body: Center(
          child: CircularProgressIndicator(), // 显示加载指示器
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapterValue) {
            final chapterTitle = chapterValue?.chapter?.Title?.replaceAll('\n', '').trim();
            return Text(chapterTitle ?? 'EPUB Viewer');
          },
        ),
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController, // 目录
        ),
      ),
      body: EpubView(
        controller: _epubController, // 设置控制器
        onDocumentLoaded: (document) {
          print('EPUB 文档加载完成');
        },
        onChapterChanged: (chapter) {
          print('章节已更改: ${chapter}');
        },
        onDocumentError: (error) {
          print('文档错误: $error');
        },
      ),
    );
  }
}
