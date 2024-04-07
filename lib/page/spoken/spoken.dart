import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpokenPage extends StatefulWidget {
  @override
  _SpokenPageState createState() => _SpokenPageState();
}

class _SpokenPageState extends State<SpokenPage> {
  // css文件内容
  String? _loadedCss;

  @override
  void initState() {
    super.initState();
    _loadCssFile();
  }

  // 加载css文件
  Future<void> _loadCssFile() async {
    final String loadedCss =
        await rootBundle.loadString('assets/CollinsEC.css');
    setState(() {
      _loadedCss = loadedCss;
    });
  }

  String getWordHtml() {
    return '''
    <body><a name="page_top"></a>
    <div class="C1_word_header">
    <span class="C1_word_header_word">abandoned</span>
    <!--AUDIO_PLACEHOLDER-->
    <span class="C1_word_header_star">★★★☆☆</span><span class="C1_color_bar">
            <ul>
                <li class="C1_cabr_1"></li>
                <li class="C1_cabr_2"></li>
                <li class="C1_cabr_3"></li>
                <li class="C1_cabr_4"></li>
                <li class="C1_cabr_5"></li>
                <li class="C1_cabr_6"></li>
            </ul>
        </span></div>
    <div class="tab_content" id="dict_tab_101" style="display:block">
        <div class="part_main">
            <div class="collins_content">
                <div class="C1_explanation_item">
                    <div class="C1_explanation_box"><span class="C1_item_number"><a
                                href="entry://#page_top">1</a></span><span class="C1_explanation_label">[ADJ 形容词]
                        </span><span class="C1_text_blue">(场所或建筑物)舍弃不用的，无人居住的；</span>An <span
                            class="C1_inline_word">abandoned</span> place or building is no longer used or occupied.
                        <span class="C1_word_gram">[usu ADJ n]</span></div>
                    <ul>
                        <li>
                            <p class="C1_sentence_en">All that digging had left a network of <span
                                    class="C1_text_blue">abandoned</span> mines and tunnels.</p>
                            <p>东挖西掘后留下了一片废弃的矿坑。</p>
                        </li>
                        <li>
                            <p class="C1_sentence_en">//...<span class="C1_text_blue">abandoned</span> buildings that
                                become a breeding ground for crime.</p>
                            <p>沦为了犯罪温床的弃置楼群</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
      ''';
  }

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
    // 从后端获取音频地址
    const String audioUrl = 'https://hyf666.oss-cn-fuzhou.aliyuncs.com/017.mp3';
    String htmlContent = getWordHtml().replaceFirst('<!--AUDIO_PLACEHOLDER-->', buildAudioHtml(audioUrl));
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
      body: _loadedCss == null
          ? const Center(child: CircularProgressIndicator())
          : WebView(
              initialUrl: 'data:text/html;base64,$contentBase64',
              javascriptMode: JavascriptMode.unrestricted,
            ),
    );
  }
}
