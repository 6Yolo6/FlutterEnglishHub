import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_video_player/cached_video_player.dart'; // 引入缓存视频播放器库


class WordDetailPage extends StatefulWidget {
  final WordReview word;

  const WordDetailPage({Key? key, required this.word}) : super(key: key);

  @override
  _WordDetailPageState createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  // css文件内容
  String? _loadedCss;
  // 使用 CachedVideoPlayerController
  late CachedVideoPlayerController cachedVideoPlayerController;
  late CustomVideoPlayerController customVideoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // 加载css文件
    _loadCssFile();
    cachedVideoPlayerController = CachedVideoPlayerController.network(widget.word.videoUrl!);
    _initializeVideoPlayerFuture = cachedVideoPlayerController.initialize();
    customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: cachedVideoPlayerController, // 将缓存视频播放器控制器传递给 CustomVideoPlayerController
    );

  }

  @override
  void dispose() {
    cachedVideoPlayerController.dispose();
    customVideoPlayerController.dispose();
    super.dispose();
  }

  // 加载css文件
  Future<void> _loadCssFile() async {
    final String loadedCss =
        await rootBundle.loadString('assets/CollinsEC.css');
    setState(() {
      _loadedCss = loadedCss;
    });
  }

//   String getWordHtml() {
//     return '''
//     <body><a name="page_top"></a>
//     <div class="C1_word_header">
//     <span class="C1_word_header_word">abandoned</span>
//     <!--AUDIO_PLACEHOLDER-->
//     <span class="C1_word_header_star">★★★☆☆</span><span class="C1_color_bar">
//             <ul>
//                 <li class="C1_cabr_1"></li>
//                 <li class="C1_cabr_2"></li>
//                 <li class="C1_cabr_3"></li>
//                 <li class="C1_cabr_4"></li>
//                 <li class="C1_cabr_5"></li>
//                 <li class="C1_cabr_6"></li>
//             </ul>
//         </span></div>
//     <div class="tab_content" id="dict_tab_101" style="display:block">
//         <div class="part_main">
//             <div class="collins_content">
//                 <div class="C1_explanation_item">
//                     <div class="C1_explanation_box"><span class="C1_item_number"><a
//                                 href="entry://#page_top">1</a></span><span class="C1_explanation_label">[ADJ 形容词]
//                         </span><span class="C1_text_blue">(场所或建筑物)舍弃不用的，无人居住的；</span>An <span
//                             class="C1_inline_word">abandoned</span> place or building is no longer used or occupied.
//                         <span class="C1_word_gram">[usu ADJ n]</span></div>
//                     <ul>
//                         <li>
//                             <p class="C1_sentence_en">All that digging had left a network of <span
//                                     class="C1_text_blue">abandoned</span> mines and tunnels.</p>
//                             <p>东挖西掘后留下了一片废弃的矿坑。</p>
//                         </li>
//                         <li>
//                             <p class="C1_sentence_en">//...<span class="C1_text_blue">abandoned</span> buildings that
//                                 become a breeding ground for crime.</p>
//                             <p>沦为了犯罪温床的弃置楼群</p>
//                         </li>
//                     </ul>
//                 </div>
//             </div>
//         </div>
//     </div>
// </body>
//       ''';
//   }

  // 构建音频播放的HTML代码片段
  String buildAudioHtml(String audioUrl) {
  return '''
  <a style="float: left;margin-top: 8px;margin-right: 4px;" href="#" onclick="document.getElementById('audio').play(); return false;">
      <img src="https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/image/Sound.png" style="margin-bottom:-2px" border="0">
  </a>
  <audio id="audio" style="display:none;">
      <source src="$audioUrl" type="audio/mpeg">
  </audio>
  ''';
}

  @override
  Widget build(BuildContext context) {
    
    String htmlContent = widget.word.wordsDefinition!.replaceFirst('<!--AUDIO_PLACEHOLDER-->', buildAudioHtml(widget.word.audioUrl!));
    final String contentWithCss = """
      <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            $_loadedCss
          </style>
        </head>
        <body>
          $htmlContent
        </body>
      </html>
    """;

    // 将HTML内容转换为Base64编码
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(contentWithCss));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.word),
        // 右侧图标，加入生词本
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // 添加到生词本
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                // HTML Content with WebView
                Expanded(
                  child: WebView(
                    initialUrl: 'data:text/html;base64,$contentBase64',
                    javascriptMode: JavascriptMode.unrestricted, // 允许JavaScript
                  ),
                ),
                // Video Player
                Expanded(
                  child: CustomVideoPlayer(
                    customVideoPlayerController: customVideoPlayerController,
                  ),
                ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                // 视频字幕
                child: Text(
                  widget.word.subtext!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

