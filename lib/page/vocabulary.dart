import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/vocabulary_controller.dart';
import 'package:flutter_english_hub/model/WordReview.dart';
import 'package:get/get.dart';

class VocabularyPage extends StatefulWidget {

  @override
  _VocabularyPageState createState() => _VocabularyPageState();

}

class _VocabularyPageState extends State<VocabularyPage> {

  final VocabularyController vocabularyController = Get.find<VocabularyController>();
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('生词本'),
      ),
      body: Obx(() {
        if (vocabularyController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (vocabularyController.vocabularyList.isEmpty) {
          return Center(child: Text('暂无数据'));
        }

        return ListView.builder(
          itemCount: vocabularyController.vocabularyList.length,
          itemBuilder: (context, index) {
            final wordReview = vocabularyController.vocabularyList[index];
            return VocabularyCard(wordReview: wordReview,
            audioPlayer: _audioPlayer,);
          },
        );
      }),
    );
  }
}

class VocabularyCard extends StatelessWidget {
  final WordReview wordReview;
  final AudioPlayer audioPlayer;

  const VocabularyCard({required this.wordReview, Key? key, 
  required this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wordReview.word,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            if (wordReview.phoneticUk != null)
              Text(
                '英式发音: ${wordReview.phoneticUk}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            if (wordReview.phoneticUs != null)
              Text(
                '美式发音: ${wordReview.phoneticUs}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: 8.0),
            Text(
              wordReview.definition ?? '',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            if (wordReview.wordsDefinition != null)
              Text(
                wordReview.wordsDefinition!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: 8.0),
            if (wordReview.audioUrl != null || wordReview.videoUrl != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (wordReview.audioUrl != null)
                    IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: () {
                        if (wordReview.audioUrl == null || wordReview.audioUrl!.isEmpty) {
                                    Get.snackbar('', '暂无发音');
                                  } else {
                                    audioPlayer.play(UrlSource(wordReview.audioUrl!));
                                  }
                      },
                    ),
                  if (wordReview.videoUrl != null)
                    IconButton(
                      icon: Icon(Icons.video_library),
                      onPressed: () {
                        // Play video
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
