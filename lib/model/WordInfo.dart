class WordInfo {
  final String word;
  final String phoneticUk;
  final String phoneticUs;
  final String definition;

  WordInfo(
      {required this.word,
      required this.phoneticUk,
      required this.phoneticUs,
      required this.definition
      });

  @override
  String toString() {
    return 'WordInfo{word: $word, phoneticUk: $phoneticUk, phoneticUs: $phoneticUs, definition: $definition}';
  }

  factory WordInfo.fromJson(Map<String, dynamic> json) {
    return WordInfo(
      word: json['word'],
      phoneticUk: json['phoneticUk'],
      phoneticUs: json['phoneticUs'],
      definition: json['definition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'phoneticUk': phoneticUk,
      'phoneticUs': phoneticUs,
      'definition': definition,
    };
  }
}
