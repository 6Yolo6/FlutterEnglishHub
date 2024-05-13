class DailySentence {
  final int id;
  final String content;
  final String translation;
  final String imagePath;
  final String audioPath;
  final DateTime date;

  DailySentence({
    required this.id,
    required this.content,
    required this.translation,
    required this.imagePath,
    required this.audioPath,
    required this.date,
  });

  @override
  String toString() {
    return 'DailySentence{id: $id, content: $content, translation: $translation, imagePath: $imagePath, audioPath: $audioPath, date: $date}';
  }

  factory DailySentence.fromJson(Map<String, dynamic> json) {
    return DailySentence(
      id: json['id'],
      content: json['content'],
      translation: json['translation'],
      imagePath: json['imagePath'],
      audioPath: json['audioPath'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'translation': translation,
      'imagePath': imagePath,
      'audioPath': audioPath,
      'date': date.toIso8601String(),
    };
  }
}