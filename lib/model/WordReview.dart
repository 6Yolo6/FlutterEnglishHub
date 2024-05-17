
class WordReview {
  final int id;
  final String word;
  final String? phoneticUk;
  final String? phoneticUs;
  final String definition;
  final String? wordsDefinition;
  final String? audioUrl;
  final String? videoUrl;
  final String? subtext;

  WordReview(
      {required this.id,
      required this.word,
      required this.phoneticUk,
      required this.phoneticUs,
      required this.definition,
      required this.wordsDefinition,
      required this.audioUrl,
      required this.videoUrl,
      required this.subtext,
      });

  @override
  String toString() {
    return 'WordReview{id: $id, word: $word, phoneticUk: $phoneticUk, phoneticUs: $phoneticUs, definition: $definition, wordsDefinition: $wordsDefinition, audioUrl: $audioUrl, videoUrl: $videoUrl, subtext: $subtext}';
  }

  factory WordReview.fromJson(Map<String, dynamic> json) {
    return WordReview(
      id: json['id'] as int,
      word: json['word'] as String,
      phoneticUk: json['phoneticUk'] ?? '',
      phoneticUs: json['phoneticUs'] ?? '',
      definition: json['definition'] as String,
      wordsDefinition: json['wordsDefinition'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      subtext: json['subtext'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'phoneticUk': phoneticUk,
      'phoneticUs': phoneticUs,
      'definition': definition,
      'wordsDefinition': wordsDefinition,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
      'subtext': subtext,
    };
  }
}
