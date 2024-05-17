class WordBook {
  // 单词书ID
  final int id;
  // 单词书名称
  final String name;
  // 今日已新学单词数
  final int learnedToday;
  // 今日需新学单词数
  final int toLearnToday;
  // 今日已复习单词数
  final int reviewedToday;
  // 今日需复习单词数
  final int toReviewToday;
  // 已学单词总数
  final int learnedWords;
  // 单词总数
  final int totalWords;
  // 已掌握单词数
  final int masteredWords;
  // 已学天数
  final int learnedDays;
  // 共需学习天数
  final int totalDays;

  // 默认的空对象工厂方法
  WordBook.empty()
      : id = 0,
        name = '',
        learnedToday = 0,
        toLearnToday = 0,
        reviewedToday = 0,
        toReviewToday = 0,
        learnedWords = 0,
        totalWords = 0,
        masteredWords = 0,
        learnedDays = 0,
        totalDays = 0;

  WordBook(
      {required this.id,
      required this.name,
      required this.learnedToday,
      required this.toLearnToday,
      required this.reviewedToday,
      required this.toReviewToday,
      required this.learnedWords,
      required this.totalWords,
      required this.masteredWords,
      required this.learnedDays,
      required this.totalDays});

  @override
  String toString() {
    return 'WordBook{id: $id, name: $name, learnedToday: $learnedToday, toLearnToday: $toLearnToday, reviewedToday: $reviewedToday, toReviewToday: $toReviewToday, learnedWords: $learnedWords, totalWords: $totalWords, masteredWords: $masteredWords, learnedDays: $learnedDays, totalDays: $totalDays}';
  }

  factory WordBook.fromJson(Map<String, dynamic> json) {
    return WordBook(
      id: json['id'],
      name: json['name'],
      learnedToday: json['learnedToday'],
      toLearnToday: json['toLearnToday'],
      reviewedToday: json['reviewedToday'],
      toReviewToday: json['toReviewToday'],
      learnedWords: json['learnedWords'],
      totalWords: json['totalWords'],
      masteredWords: json['masteredWords'],
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
      'reviewedToday': reviewedToday,
      'toReviewToday': toReviewToday,
      'learnedWords': learnedWords,
      'totalWords': totalWords,
      'masteredWords': masteredWords,
      'learnedDays': learnedDays,
      'totalDays': totalDays,
    };
  }
}
