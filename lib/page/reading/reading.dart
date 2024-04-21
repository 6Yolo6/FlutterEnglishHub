import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int pages = 0;
  bool isReady = false;
  String? filePath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  _loadPdf() async {
    try {
      var dio = Dio();
      var dir = await getApplicationDocumentsDirectory();
      var file = File('${dir.path}/myfile.pdf');
  
      await dio.download(
        'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/pdf/450dbc715b5644a0b9d23b1fc24469fb疯狂英语·口语版 2015第01期.pdf',
        file.path,
      );
  
      setState(() {
        filePath = file.path;
      });
    } catch (e) {
      print('下载 PDF 文件失败：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Page'),
      ),
      body: Container(
        child: isReady ? const Center(
          child: Text('Reading Page Content'),
        ) : filePath != null ? PDFView(
          filePath: filePath,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          onRender: (_pages) {
            setState(() {
              pages = _pages!;
              isReady = true;
            });
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (int? page, int? total) {
            print('page change: $page/$total');
          },
        ) : CircularProgressIndicator(),
      ),
    );
  }
}