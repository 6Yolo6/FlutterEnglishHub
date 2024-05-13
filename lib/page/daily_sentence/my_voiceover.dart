import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/voiceover_controller.dart';
import 'package:flutter_english_hub/model/Voiceover.dart';
import 'package:get/get.dart';

class MyVoiceoverPage extends StatefulWidget {
  @override
  _MyVoiceoverPageState createState() => _MyVoiceoverPageState();
}

class _MyVoiceoverPageState extends State<MyVoiceoverPage> {
  late VoiceoverController myVoiceoverController = Get.find<VoiceoverController>();
  late List<AudioPlayer> _audioPlayers;
  late List<Duration> _durations;
  late List<bool> _isPlaying;

  @override
  void initState() {
    super.initState();
    _audioPlayers = [];
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Voiceover'.tr,
          style: TextStyle(
            color: Get.theme.colorScheme.onPrimary,
          )
        ),
        backgroundColor: Get.theme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Get.theme.primaryIconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Voiceover>>(
        future: fetchVoiceovers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var myVoiceovers = snapshot.data;
            return ListView.builder(
              itemCount: myVoiceovers?.length ?? 0,
              itemBuilder: (context, index) {
                var voiceover = myVoiceovers![index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(voiceover.avatar),
                    ),
                    title: Text(voiceover.username),
                    subtitle: Text('10句专注练习'), // Example text
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            
                            if (_isPlaying[index]) {
                              // _audioPlayers[index].pause();
                            } else {
                              // _audioPlayers[index].play(UrlSource(voiceover.audioUrl));
                            }
                            setState(() {
                              _isPlaying[index] = !_isPlaying[index];
                            });
                          },
                        ),
                        Text(_durations.isNotEmpty && _durations.length > index
                            ? _durations[index].toString().split('.').first
                            : '00:00'),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Implement delete functionality
                          },
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Voiceover>> fetchVoiceovers() async {
    var voiceovers = await myVoiceoverController.refreshMyVoiceovers();
    _isPlaying = List.filled(voiceovers.length, false);
    _durations = List.filled(voiceovers.length, Duration.zero);
    _audioPlayers = List.generate(voiceovers.length, (index) => AudioPlayer());
  
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
  
    return voiceovers;
  }
}
