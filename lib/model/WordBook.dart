class WordBook {
  // 单词书ID
  final int id;
  // 单词书名称
  final String name;
  // 今日已学单词数
  final int learnedToday;
  // 今日需学单词数
  final int toLearnToday;
  // 已学单词总数
  final int learnedWords;
  // 单词总数
  final int totalWords;
  // 已掌握单词数
  final int masterWords;
  // 已学天数
  final int learnedDays;
  // 共需学习天数
  final int totalDays;

  WordBook(
      {required this.id,
      required this.name,
      required this.learnedToday,
      required this.toLearnToday,
      required this.learnedWords,
      required this.totalWords,
      required this.masterWords,
      required this.learnedDays,
      required this.totalDays});

  @override
  String toString() {
    return 'WordBook{id: $id, name: $name, learnedToday: $learnedToday, toLearnToday: $toLearnToday, learnedWords: $learnedWords, totalWords: $totalWords, masterWords: $masterWords, learnedDays: $learnedDays, totalDays: $totalDays}';
  }

  factory WordBook.fromJson(Map<String, dynamic> json) {
    return WordBook(
      id: json['id'],
      name: json['name'],
      learnedToday: json['learnedToday'],
      toLearnToday: json['toLearnToday'],
      learnedWords: json['learnedWords'],
      totalWords: json['totalWords'],
      masterWords: json['masterWords'],
      learnedDays: json['learnedDays'],
      totalDays: json['totalDays'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'learnedToday': learnedToday,
      'toLearnToday': toLearnToday,
      'learnedWords': learnedWords,
      'totalWords': totalWords,
      'masterWords': masterWords,
      'learnedDays': learnedDays,
      'totalDays': totalDays,
    };
  }
}
