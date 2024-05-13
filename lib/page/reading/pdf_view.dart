import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import 'package:flutter_english_hub/service/reading_progress_service.dart';

class PdfView extends StatefulWidget {
  final String pdfPath; // PDF 文件路径
  final int eBookId; // PDF ID
  final int currentPage; // 当前页码

  const PdfView({super.key, required this.pdfPath, required this.eBookId, required this.currentPage});

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late ReadingProgressService readingProgressService = Get.find<ReadingProgressService>();
  late PdfViewerController _controller;
  bool _isTextSelectionEnabled = true; // 文本选择
  int _currentPage = 1; // 存储当前页码的变量

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController(); // PDF 查看器控制器
  }

  @override
  void dispose() {
    super.dispose();
    _saveReadingProgress();
  }

  void _saveReadingProgress() async {
    // 调用保存阅读进度的接口
    bool success = await readingProgressService.saveOrUpdateProgress(widget.eBookId, _currentPage.toString());
    if (success) {
      print('Reading progress saved successfully.');
    } else {
      print('Failed to save reading progress.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'), // AppBar 标题
      ),
      body: PdfViewer.uri(
        Uri.parse(widget.pdfPath), // 从 URI 加载 PDF
        controller: _controller,
        params: PdfViewerParams(
          // 启用文本选择
          enableTextSelection: _isTextSelectionEnabled,
          loadingBannerBuilder: (context, bytesDownloaded, totalBytes) {
            return Center(
              child: CircularProgressIndicator(
                value: totalBytes != null ? bytesDownloaded / totalBytes : null, // 加载指示器
              ),
            );
          },
          pageOverlaysBuilder: (context, pageRect, page) {
            _currentPage = page.pageNumber; // 更新当前页码变量
            return [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Page ${page.pageNumber}', // 显示页码
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ];
          },
          viewerOverlayBuilder: (context, size) => [
            PdfViewerScrollThumb(
              controller: _controller,
              orientation: ScrollbarOrientation.right, // 滚动方向右侧
            ),
          ],
        ),
      ),
    );
  }
}

