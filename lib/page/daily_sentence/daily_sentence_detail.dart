import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/daily_sentence_controller.dart';
import 'package:flutter_english_hub/controller/voiceover_controller.dart';
import 'package:flutter_english_hub/model/DailySentence.dart';
import 'package:flutter_english_hub/model/Voiceover.dart';
import 'package:flutter_english_hub/page/daily_sentence/my_voiceover.dart';
import 'package:flutter_english_hub/page/drawer/favorite.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
import 'package:audioplayers/audioplayers.dart' as audioPlayer;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class DailySentenceDetailPage extends StatefulWidget {
  final DailySentence detail;

  const DailySentenceDetailPage({
    Key? key,
    // required this.sentenceId,
    required this.detail,
  }) : super(key: key);

  @override
  _DailySentenceDetailPageState createState() =>
      _DailySentenceDetailPageState();
}

class _DailySentenceDetailPageState extends State<DailySentenceDetailPage> {
  // late DailySentenceController dailySentenceController = Get.find<DailySentenceController>();
  late VoiceoverController voiceoverController =
      Get.find<VoiceoverController>();
  final ScrollController _scrollController = ScrollController();
  Future<List<Voiceover>> _initFuture = Future.value([]);
  late List<Voiceover> voiceovers = [];
  late PageController _pageController;
  late flutterSound.FlutterSoundRecorder _recorder;
  late audioPlayer.AudioPlayer _audioPlayer;
  bool _isRecording = false;
  late List<Duration> _durations = [];
  double playbackRate = 1.0; // 句子默认播放速率为 1.0
  List<double> playbackRates = []; // 用于存储每个配音文件的播放速率
  audioPlayer.PlayerState? _playerState;
  DateTime _selectedDate = DateTime.now();
  late CalendarFormat _calendarFormat = CalendarFormat.month;

  late List<audioPlayer.AudioPlayer> _audioPlayers;
  late List<bool> _isPlaying = List.filled(voiceovers.length, false);

  @override
  void initState() {
    super.initState();
    _recorder = flutterSound.FlutterSoundRecorder();
    _audioPlayer = audioPlayer.AudioPlayer();
    _audioPlayers = [];
    _openRecorder();
    // 根据今日日期计算初始页面
    _pageController = PageController(
      initialPage: 0,
    );

    _initFuture = _initData();
  }

  Future<List<Voiceover>> _initData() async {
    voiceovers = await voiceoverController.refreshVoiceovers(widget.detail.id);
    print('实际数据: $voiceovers');
    _durations = List.filled(voiceovers.length, Duration.zero);

    _audioPlayers =
        voiceovers.map((voiceover) => audioPlayer.AudioPlayer()).toList();

    // 为每个音频文件设置源并获取长度
    for (var i = 0; i < voiceovers.length; i++) {
      _audioPlayers[i].setSourceUrl(voiceovers[i].audioUrl);
      _audioPlayers[i].onDurationChanged.listen((Duration d) {
        print('Duration: $d');
        setState(() {
          _durations[i] = d; // 将音频文件的长度添加到列表中
        });
      });
    }

    // 初始化每个配音文件的播放速率
    playbackRates = List.filled(voiceovers.length, 1.0);

    return voiceovers;
  }

  Future<void> _openRecorder() async {
    await _recorder.openRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Microphone permission not granted');
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleRecording() async {
    if (_isRecording) {
      await _recorder.stopRecorder();
    } else {
      await _recorder.startRecorder(toFile: 'audio.aac');
    }
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  void _fetchSentence(DateTime date) async {
    // Simulate fetching sentence from backend for the given date
    print("Fetching new sentence for date: $date");
    // Simulate a new sentence received from backend
    setState(() {
      _selectedDate = date;
      // Update widget's state with new sentence details if received from backend
    });
  }

  Widget _buildPageContent(DailySentence detail) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(detail.imagePath, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('MMM dd').format(detail.date),
                  style: GoogleFonts.architectsDaughter(
                      fontSize: 24, color: Colors.grey),
                ),
                Text(
                  detail.content,
                  style: GoogleFonts.architectsDaughter(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  detail.translation,
                  style: GoogleFonts.architectsDaughter(
                      fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 收藏图标
                    IconButton(
                      icon: Icon(Icons.star),
                      color: Colors.red,
                      onPressed: () {
                        print('收藏');
                      },
                    ),
                    // 播放句子音频
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      color: Colors.blue,
                      onPressed: () async {
                        _audioPlayer
                            .play(audioPlayer.UrlSource(detail.audioPath));
                      },
                    ),
                    // 倍速播放图标
                    PopupMenuButton<double>(
                      icon: Icon(Icons.fast_forward_outlined),
                      onSelected: (value) {
                        setState(() {
                          playbackRate = value;
                        });
                        _audioPlayer.setPlaybackRate(playbackRate);
                        _audioPlayer
                            .play(audioPlayer.UrlSource(detail.audioPath));
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0.5,
                          child: Text("0.5x"),
                        ),
                        PopupMenuItem(
                          value: 1.0,
                          child: Text("1.0x"),
                        ),
                        PopupMenuItem(
                          value: 1.5,
                          child: Text("1.5x"),
                        ),
                        PopupMenuItem(
                          value: 2.0,
                          child: Text("2.0x"),
                        ),
                      ],
                    ),
                    // 分享图标
                    IconButton(
                      icon: Icon(Icons.share),
                      color: Colors.green,
                      onPressed: () => Share.share(
                          '${detail.content} - ${detail.translation}'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hot Voiceover".tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.textTheme.headline6?.color,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 跳转到我的配音页面
                        Get.to(() => MyVoiceoverPage(),
                            transition: Transition.fade,
                            duration: Duration(seconds: 1));
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Get.theme.colorScheme.secondary),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "My Voiceover".tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.textTheme.headline6?.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                FutureBuilder<List<Voiceover>>(
                  future: _initFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Voiceover>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // 显示一个进度指示器
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // 显示错误信息
                    } else {
                      // Future 已完成，显示实际的界面
                      var voiceovers = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: voiceovers?.length,
                        itemBuilder: (context, index) {
                          var voiceover = voiceovers![index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(voiceover.avatar),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // 显示用户名
                                Text(voiceover.username),
                                SizedBox(width: 10),
                                // 显示发布时间，格式化
                                Text(
                                  '发布于: ${DateFormat('HH:mm').format(voiceover.createTime)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Get.theme.textTheme.headline6?.color,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (_isPlaying[index]) {
                                          await _audioPlayers[index].pause();
                                          _isPlaying[index] = false;
                                        } else {
                                          await _audioPlayers[index].play(
                                              audioPlayer.UrlSource(
                                                  voiceovers[index].audioUrl));
                                          _isPlaying[index] = true;
                                        }
                                        setState(() {}); // 通知 Flutter 重新构建 UI
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, // 调整水平填充
                                          vertical: 4.0, // 调整垂直填充
                                        ),
                                        decoration: BoxDecoration(
                                          color: Get.theme.colorScheme.secondary, // 使用主题的次要颜色
                                          borderRadius: BorderRadius.circular(30.0), // 调整边框半径
                                        ),
                                        child: Row(
                                          children: [
                                            Text(_durations.isNotEmpty &&
                                                    _durations.length > index
                                                ? _durations[index]
                                                    .toString()
                                                    .split('.')
                                                    .first
                                                : ''),
                                            Icon(_isPlaying[index]
                                                ? Icons.volume_up
                                                : Icons.volume_mute),
                                            PopupMenuButton<double>(
                                              onSelected: (double value) async {
                                                await _audioPlayers[index]
                                                    .setPlaybackRate(
                                                        playbackRates[index]);
                                              },
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<double>>[
                                                const PopupMenuItem<double>(
                                                  value: 0.5,
                                                  child: Text('0.5x'),
                                                ),
                                                const PopupMenuItem<double>(
                                                  value: 1.0,
                                                  child: Text('1.0x'),
                                                ),
                                                const PopupMenuItem<double>(
                                                  value: 1.5,
                                                  child: Text('1.5x'),
                                                ),
                                                const PopupMenuItem<double>(
                                                  value: 2.0,
                                                  child: Text('2.0x'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Stack(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.thumb_up),
                                  onPressed: () {
                                    // 点赞
                                    print('点赞评论 $index');
                                  },
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: Text(
                                      '${voiceover.likeCount}', // Use the likeCount of the voiceover
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // onTap: () => _audioPlayer.play(
                            //     audioPlayer.UrlSource(voiceover.audioUrl)),
                          );
                        },
                      );
                    }
                  },
                )
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: voiceovers.length,
                //   itemBuilder: (context, index) {
                //     var voiceover = voiceovers[index];
                //     return ListTile(
                //       leading: CircleAvatar(
                //         backgroundImage: NetworkImage(voiceover.avatar),
                //         // child: Icon(Icons.person),
                //       ),
                //       title: Text(voiceover.username),
                //       subtitle: Row(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 8.0, vertical: 4.0),
                //             decoration: BoxDecoration(
                //               color: Colors.blue,
                //               borderRadius: BorderRadius.circular(20.0),
                //             ),
                //             child: GestureDetector(
                //               // onTap: () async {
                //               //   if (_isPlaying) {
                //               //     await _audioPlayer.pause();
                //               //   } else {
                //               //     await _audioPlayer.play(
                //               //         audioPlayer.UrlSource(voiceover.audioUrl));
                //               //   }
                //               // },
                //               onTap: () async {
                //                 if (_isPlaying[index]) {
                //                   await _audioPlayers[index].pause();
                //                   _isPlaying[index] = false;
                //                 } else {
                //                   await _audioPlayers[index].play(
                //                       audioPlayer.UrlSource(
                //                           voiceovers[index].audioUrl));
                //                   _isPlaying[index] = true;
                //                 }
                //               },
                //               child: Row(
                //                 children: [
                //                   Text(_durations.isNotEmpty && _durations.length > index && _durations[index] != null
                //                     ? _durations[index].toString().split('.').first
                //                     : ''),
                //                   Icon(_isPlaying[index] ? Icons.volume_up : Icons.volume_mute),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       trailing: Stack(
                //         children: <Widget>[
                //           IconButton(
                //             icon: Icon(Icons.thumb_up),
                //             onPressed: () {
                //               // 点赞
                //               print('点赞评论 $index');
                //             },
                //           ),
                //           Positioned(
                //             right: 0,
                //             child: Container(
                //               padding: EdgeInsets.all(1),
                //               decoration: BoxDecoration(
                //                 color: Colors.red,
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               constraints: BoxConstraints(
                //                 minWidth: 12,
                //                 minHeight: 12,
                //               ),
                //               child: Text(
                //                 '${voiceover.likeCount}', // Use the likeCount of the voiceover
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 8,
                //                 ),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () => _audioPlayer
                //           .play(audioPlayer.UrlSource(voiceover.audioUrl)),
                //     );
                //   },
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.appBarTheme.backgroundColor,
        iconTheme: Get.theme.appBarTheme.iconTheme,
        title: Text('每日一句',
            style: GoogleFonts.architectsDaughter(
                color: Get.theme.appBarTheme.titleTextStyle?.color)),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
              );
              if (picked != null && picked != _selectedDate) {
                _fetchSentence(picked);
              }
            },
          ),
          // 跳转收藏页面
          IconButton(
            // 五角星
            icon: Icon(Icons.star),
            onPressed: () => {
              Get.to(() => FavoritePage(),
                  transition: Transition.fade, duration: Duration(seconds: 1))
            },
          ),
        ],
      ),

      // body: Obx(() {
      //   return ListView.builder(
      //     controller: _scrollController,
      //     itemCount: dailySentenceController.dailySentences.length,
      //     itemBuilder: (context, index) {
      //       return _buildPageContent(dailySentenceController.dailySentences[index]);
      //     },
      //   );
      // }),
      body: _buildPageContent(widget.detail),

      floatingActionButton: FloatingActionButton(
        onPressed: _toggleRecording,
        child: Icon(_isRecording ? Icons.stop : Icons.mic),
      ),
    );
  }
}
