
class Word {
  final int id;
  final String word;
  final int wordsId;
  final String phoneticUk;
  final String phoneticUs;
  final String? audioUrlUk;
  final String? audioUrlUs;
  final String definition;

  Word({
    required this.id,
    required this.word,
    required this.wordsId,
    required this.phoneticUk,
    required this.phoneticUs,
    required this.audioUrlUk,
    required this.audioUrlUs,
    required this.definition,
  });

  @override
  String toString() {
    return 'Word{id: $id, word: $word, wordsId: $wordsId, phoneticUk: $phoneticUk, phoneticUs: $phoneticUs, audioUrlUk: $audioUrlUk, audioUrlUs: $audioUrlUs, definition: $definition}';
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      word: json['word'],
      wordsId: json['wordsId'],
      phoneticUk: json['phoneticUk'],
      phoneticUs: json['phoneticUs'],
      audioUrlUk: json['audioUrlUk'] ?? '',
      audioUrlUs: json['audioUrlUs'] ?? '',
      definition: json['definition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'wordsId': wordsId,
      'phoneticUk': phoneticUk,
      'phoneticUs': phoneticUs,
      'audioUrlUk': audioUrlUk,
      'audioUrlUs': audioUrlUs,
      'definition': definition,
    };
  }
}